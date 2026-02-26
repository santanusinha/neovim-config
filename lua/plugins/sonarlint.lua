return {
    {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "sonarlint-language-server" } },
    },
    {
        "santanusinha/sonarlint.nvim",
        dependencies = { "williamboman/mason.nvim" },
        ft = { "java", "python", "javascript", "typescript", "rust" },
        config = function()
            -- 1. Force reload secrets
            package.loaded["secrets"] = nil
            local has_secrets, secrets = pcall(require, "secrets")

            local sonar_servers = {}
            local credentials = {}
            if has_secrets and type(secrets) == "table" then
                sonar_servers = secrets.connections
                credentials = secrets.sonar_credentials
            end

            local mason_path = vim.fn.stdpath("data") .. "/mason/share/sonarlint-analyzers"

            -- 2. Setup with initialization_options to prevent the "nil credentials" race condition
            require("sonarlint").setup({
                connected = {
                    get_credentials = function(client_id, url)
                        if string.find(url, "EU_", 1, true) == 1 then
                            url = "sonarcloud"
                        end
                        local token = nil
                        for _, object in ipairs(credentials) do
                            if object["url"] == url then
                                token = object["token"]
                            end
                        end
                        if token == nil then
                            vim.notify("No credentials found for Sonar server: " .. url, vim.log.levels.WARN)
                        end
                        return token
                    end
                },
                server = {
                    cmd = {
                        "sonarlint-language-server",
                        "-stdio",
                        "-analyzers",
                        vim.fn.expand(mason_path .. "/sonarjava.jar"),
                        vim.fn.expand(mason_path .. "/sonarpython.jar"),
                        vim.fn.expand(mason_path .. "/sonarjs.jar"),
                    },
                    settings = {
                        sonarlint = {
                            connectedMode = {
                                connections = sonar_servers,
                            },
                        },
                    },
                    before_init = function(params, config)
                        -- This is a workaround to fetch the projectKey from .sonarqube.json before the LSP client is fully initialized
                        local sonar_json = vim.fs.find(".sonarqube.json",
                                            { upward = true, path = params.rootPath })
                        if #sonar_json == 0 then
                            return
                        end
                        local f = io.open(sonar_json[1], "r")
                        if not f then return end
                        local data = vim.fn.json_decode(f:read("*a"))
                        f:close()

                        if data and data.projectKey then
                            config.settings.sonarlint.connectedMode.project = {
                                connectionId = data.connectionId or "sonarcloud",
                                projectKey = data.projectKey,
                            }
                            vim.notify("Sonar remote project set to: " .. data.projectKey .. " for connection: " .. data.connectionId, vim.log.levels.INFO)
                        end
                    end
                },
                filetypes = { "java", "python", "javascript", "typescript", "rust" },

            })
        end,
    },
}

