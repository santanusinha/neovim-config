-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local install_path = vim.fn.stdpath("data")
local cache_path = vim.fn.stdpath("cache")
local workspace_dir = cache_path .. "/jdtls-workspace/" .. project_name

local system_os = "linux"

-- Determine OS
if vim.fn.has("mac") == 1 then
    system_os = "mac"
elseif vim.fn.has("unix") == 1 then
    system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    system_os = "win"
else
    print("OS not found, defaulting to 'linux'")
    system_os = "linux"
end

-- Needed for debugging
local bundles = {
    -- vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
    vim.fn.glob(install_path .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

-- Needed for running/debugging unit tests
--vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob( install_path .. "/mason/share/java-test/*.jar", 1), "\n"))

local keymap = vim.keymap

-- Java specific keymaps
keymap.set("n", '<leader>jo', require('jdtls').organize_imports, { desc = "[J]ava [O]rganize Imports"})
keymap.set("n", '<C-M-o>', require('jdtls').organize_imports, { desc = "[J]ava [O]rganize Imports (Ctrl-Alt-O)"})

keymap.set("n", '<leader>ju', require('jdtls').update_projects_config, { desc = "[J]ava [U]pdate/Resync mvn/gradle config"})

-- Testing
keymap.set("n", '<leader>jt', require('jdtls').test_class, { desc = "[J]ava Run Test [C]lass (Ctrl-Shift-F10)"})
keymap.set("n", '<C-S-F10>', require('jdtls').test_class, { desc = "[J]ava Run Test [C]lass"})
keymap.set("n", '<leader>tc', require('jdtls').test_nearest_method, { desc = "[J]ava Run [T]est Method (Ctrl-Shift-F9)"})
keymap.set("n", '<C-S-F9>', require('jdtls').test_nearest_method, { desc = "[J]ava Run [T]est Method"})

-- Extraction
keymap.set("n", '<leader>jv', require('jdtls').extract_variable, { desc = "[J]ava Extract [V]ariable (Ctrl-Alt-v)"})
keymap.set("n", '<C-M-v>', require('jdtls').extract_variable, { desc = "[J]ava Extract [V]ariable"})
keymap.set("n", '<leader>jc', require('jdtls').extract_variable, { desc = "[J]ava Extract [C]onstant (Ctrl-Alt-c)"})
keymap.set("n", '<C-M-c>', require('jdtls').extract_variable, { desc = "[J]ava Extract [C]onstant"})
keymap.set("n", '<leader>jm', require('jdtls').extract_variable, { desc = "[J]ava Extract [M]ethod (Ctrl-Alt-m)"})
keymap.set("n", '<C-M-m>', require('jdtls').extract_variable, { desc = "[J]ava Extract [M]ethod"})

-- Code generation
keymap.set("n", '<leader>ji', require('jdtls').extract_variable, { desc = "[J]ava Extract [V]ariable (Ctrl-Alt-v)"})




-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. install_path .. '/mason/share/jdtls/lombok.jar',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- Eclipse jdtls location
        '-jar',
        install_path .. '/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
        '-configuration',
        install_path .. '/mason/packages/jdtls/config_' .. system_os,
        '-data',
        workspace_dir,
    },

    -- we find the root directory by finding the source root. Otherwise it will cok up badly for multi-module projects
    root_dir = require("jdtls.setup").find_root({ ".git" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    settings = {
        java = {
            -- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
            --home = "/usr/lib/jvm/java-21-openjdk-amd64",
            home = "/usr/lib/jvm/java-25-openjdk-amd64/",
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
                -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "/usr/lib/jvm/java-8-openjdk-amd64",
                    },
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk-amd64",
                    },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk-amd64",
                    }
                },
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            signatureHelp = { enabled = true },
            format = {
                enabled = true,
                -- Formatting works by default, but you can refer to a specific file/URL if you choose
                settings = {
                        url = install_path .. "/extras/java-checkstyle.xml"
                    },
                },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                    importOrder = {
                        "java",
                        "javax",
                        "com",
                        "org",
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },
        },
        -- Needed for auto-completion with method signatures and placeholders
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            -- References the bundles defined above to support Debugging and Unit Testing
            bundles = bundles,
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
        },
    }

    -- Needed for debugging
    config["on_attach"] = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
    end

    local function run_java_app_with_args()
        local jdtls_dap = require('jdtls.dap')
        local root_dir = require('jdtls.setup').find_root({ ".git", "mvnw", "gradlew" })
        local config_dir = root_dir .. "/jdtls-run-configs"
        local config_file = config_dir .. "/run-config.json"

        -- Ensure directory exists
        if vim.fn.isdirectory(config_dir) == 0 then
            vim.fn.mkdir(config_dir, "p")
        end

        -- Try to load existing config
        local existing_config = nil
        if vim.fn.filereadable(config_file) == 1 then
            local f = io.open(config_file, "r")
            if f then
                local content = f:read("*a")
                f:close()
                existing_config = vim.fn.json_decode(content)
            end
        end

        if existing_config then
            -- Run with existing config
            -- We still need to fetch main configs to get the full classpaths etc for the specific main class
            jdtls_dap.fetch_main_configs(nil, function(configs)
                local found = false
                for _, config in ipairs(configs) do
                    if config.mainClass == existing_config.mainClass then
                        config.args = existing_config.args
                        require('dap').run(config)
                        found = true
                        break
                    end
                end
                if not found then
                    vim.notify("Saved main class " .. existing_config.mainClass .. " not found. Picking new one.", vim.log.levels.WARN)
                    -- Reset and trigger normal flow? Or just notify?
                    -- For now, let's just fall back to normal flow
                end
            end)
            if existing_config then return end -- If we already handled it, don't proceed
        end

        -- Discover main classes using jdtls
        jdtls_dap.fetch_main_configs(nil, function(configs)
            if not configs or #configs == 0 then
                vim.notify("No main classes found")
                return
            end

            -- Pick one class
            require('jdtls.ui').pick_one_async(
                configs,
                'Main Class> ',
                function(config) return config.name end,
                function(selected_config)
                    if not selected_config then return end

                    -- Ask for input parameters
                    vim.ui.input({ prompt = 'Program arguments: ' }, function(args)
                        local dap = require('dap')
                        -- Merge selected config with args
                        selected_config.args = args or ""
                        
                        -- Save config
                        local save_data = {
                            mainClass = selected_config.mainClass,
                            args = selected_config.args
                        }
                        local f = io.open(config_file, "w")
                        if f then
                            f:write(vim.fn.json_encode(save_data))
                            f:close()
                        end

                        -- Run using DAP
                        dap.run(selected_config)
                    end)
                end
            )
        end)
    end

    -- Create the command
    vim.api.nvim_buf_create_user_command(0, 'JavaRunMain', run_java_app_with_args, { desc = 'Run Java main with args' })

    -- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
    jdtls.start_or_attach(config)


