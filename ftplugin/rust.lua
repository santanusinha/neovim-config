local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json", ".git" }),
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

vim.lsp.enable("rust_analyzer")

local keymap = vim.keymap
local opts = { buffer = true }

keymap.set("n", "<leader>ro", function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.organizeImports" },
            diagnostics = {},
        },
    })
end, vim.tbl_extend("force", opts, { desc = "[R]ust [O]rganize Imports" }))

keymap.set("n", "<C-M-o>", function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.organizeImports" },
            diagnostics = {},
        },
    })
end, vim.tbl_extend("force", opts, { desc = "[R]ust [O]rganize Imports (Ctrl-Alt-O)" }))

local function cargo_term(cmd)
    vim.cmd("sp")
    vim.cmd("resize 15")
    vim.cmd("terminal " .. cmd)
    vim.cmd("startinsert")
end

local function latest_debug_binary(root)
    local target_debug = root .. "/target/debug"
    local fs = vim.uv or vim.loop
    local scan = fs.fs_scandir(target_debug)
    if not scan then
        return nil
    end

    local latest_path = nil
    local latest_mtime = -1

    while true do
        local name, ftype = fs.fs_scandir_next(scan)
        if not name then
            break
        end

        if ftype == "file"
            and not name:match("%.d$")
            and not name:match("%.rlib$")
            and not name:match("%.rmeta$")
            and not name:match("%.json$")
        then
            local path = target_debug .. "/" .. name
            local stat = fs.fs_stat(path)
            if stat and stat.mtime and stat.mtime.sec and stat.mtime.sec > latest_mtime then
                latest_mtime = stat.mtime.sec
                latest_path = path
            end
        end
    end

    return latest_path
end

local function cargo_build_and_debug_latest()
    local root = vim.fs.root(0, { "Cargo.toml", ".git" }) or vim.fn.getcwd()
    vim.notify("Running cargo build...", vim.log.levels.INFO)

    vim.system({ "cargo", "build" }, { cwd = root, text = true }, function(result)
        vim.schedule(function()
            if result.code ~= 0 then
                vim.notify("cargo build failed\n" .. (result.stderr or ""), vim.log.levels.ERROR)
                return
            end

            local program = latest_debug_binary(root)
            if not program then
                vim.notify("No debug executable found in target/debug", vim.log.levels.WARN)
                return
            end

            require("dap").run({
                name = "Debug latest binary (codelldb)",
                type = "codelldb",
                request = "launch",
                program = program,
                cwd = root,
                stopOnEntry = false,
                args = {},
            })
        end)
    end)
end

local function cargo_build_and_debug_latest_with_args()
    local root = vim.fs.root(0, { "Cargo.toml", ".git" }) or vim.fn.getcwd()
    vim.notify("Running cargo build...", vim.log.levels.INFO)

    vim.system({ "cargo", "build" }, { cwd = root, text = true }, function(result)
        vim.schedule(function()
            if result.code ~= 0 then
                vim.notify("cargo build failed\n" .. (result.stderr or ""), vim.log.levels.ERROR)
                return
            end

            local program = latest_debug_binary(root)
            if not program then
                vim.notify("No debug executable found in target/debug", vim.log.levels.WARN)
                return
            end

            vim.ui.input({ prompt = "Program args: " }, function(input)
                local args = {}
                if input and input ~= "" then
                    args = vim.split(input, "%s+", { trimempty = true })
                end

                require("dap").run({
                    name = "Debug latest binary (codelldb + args)",
                    type = "codelldb",
                    request = "launch",
                    program = program,
                    cwd = root,
                    stopOnEntry = false,
                    args = args,
                })
            end)
        end)
    end)
end

keymap.set("n", "<leader>rc", function()
    cargo_term("cargo check")
end, vim.tbl_extend("force", opts, { desc = "[R]ust Cargo [C]heck" }))

keymap.set("n", "<leader>rt", function()
    cargo_term("cargo test")
end, vim.tbl_extend("force", opts, { desc = "[R]ust Cargo [T]est" }))

keymap.set("n", "<leader>rR", function()
    cargo_term("cargo run")
end, vim.tbl_extend("force", opts, { desc = "[R]ust Cargo [R]un" }))

keymap.set("n", "<leader>rd", cargo_build_and_debug_latest,
    vim.tbl_extend("force", opts, { desc = "[R]ust Build and [D]ebug Latest Binary" }))

keymap.set("n", "<leader>rD", cargo_build_and_debug_latest_with_args,
    vim.tbl_extend("force", opts, { desc = "[R]ust Build and [D]ebug Latest Binary With Args" }))
