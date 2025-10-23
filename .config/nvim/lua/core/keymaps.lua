-- -----------------------------
-- Minimal Which-Key Popup + Leader Key Mappings
-- -----------------------------
local wk = {}

-- Define leader key mappings for popup and keybinds
wk.leader_mappings = {
    f = { name = "Files",
        ff = "Find files",
        fg = "Live grep",
        fb = "Buffers",
        fh = "Help tags",
    },
    e = "Toggle Explorer",
    g = { name = "Git",
        gs = "Status",
        gc = "Commit",
        gp = "Push",
    },
    d = { name = "DAP",
        b = "Breakpoint",
        c = "Continue",
        t = "Terminate",
    },
    l = { name = "LSP",
        rn = "Rename",
        ca = "Code Action",
    },
    w = { name = "Windows",
        s = "Split",
        v = "VSplit",
        h = "Move Left",
        j = "Move Down",
        k = "Move Up",
        l = "Move Right",
    },
}

-- Create highlight groups
vim.cmd("highlight WkKey guifg=#88c0d0 gui=bold")
vim.cmd("highlight WkGroup guifg=#81a1c1 gui=bold")

-- Build popup lines recursively
local function build_lines(tbl, prefix)
    local lines = {}
    local highlights = {}
    prefix = prefix or ""
    for k, v in pairs(tbl) do
        if type(v) == "table" and v.name then
            local line = string.format("%s%s → %s", prefix, k, v.name)
            table.insert(lines, line)
            table.insert(highlights, {line=#lines, col_start=#prefix, col_end=#prefix+#k, group="WkKey"})
            local sub_lines, sub_hl = build_lines(v, prefix .. k .. " ")
            for _, l in ipairs(sub_lines) do table.insert(lines, l) end
            for _, h in ipairs(sub_hl) do table.insert(highlights, h) end
        elseif type(v) == "string" then
            local line = string.format("%s%s → %s", prefix, k, v)
            table.insert(lines, line)
            table.insert(highlights, {line=#lines, col_start=#prefix, col_end=#prefix+#k, group="WkKey"})
        end
    end
    return lines, highlights
end

-- Show popup function
function wk.show_popup(tbl)
    local lines, highlights = build_lines(tbl)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = 0
    for _, l in ipairs(lines) do
        if #l > width then width = #l end
    end
    width = width + 2

    local opts = {
        relative = "editor",
        width = width,
        height = #lines,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - #lines) / 2),
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    for _, hl in ipairs(highlights) do
        vim.api.nvim_buf_add_highlight(buf, -1, hl.group, hl.line-1, hl.col_start, hl.col_end)
    end

    vim.cmd(string.format([[
      autocmd! BufLeave <buffer=%d> ++once lua vim.api.nvim_win_close(%d, true)
    ]], buf, win))

    vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(win, true) end, {buffer=buf, nowait=true, noremap=true, silent=true})
    vim.keymap.set('n', '<CR>', function() vim.api.nvim_win_close(win, true) end, {buffer=buf, nowait=true, noremap=true, silent=true})
end

-- Popup key
vim.keymap.set('n', '<leader>w', function()
    wk.show_popup(wk.leader_mappings)
end, { noremap=true, silent=true })

-- -----------------------------
-- Bind actual leader mappings
-- -----------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Files
map('n', '<leader>ff', require('telescope.builtin').find_files, opts)
map('n', '<leader>fg', require('telescope.builtin').live_grep, opts)
map('n', '<leader>fb', require('telescope.builtin').buffers, opts)
map('n', '<leader>fh', require('telescope.builtin').help_tags, opts)

-- Explorer
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- Git
map('n', '<leader>gs', ':G<CR>', opts)
map('n', '<leader>gc', ':G commit<CR>', opts)
map('n', '<leader>gp', ':G push<CR>', opts)

-- LSP
map('n', '<leader>rn', vim.lsp.buf.rename, opts)
map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', 'gi', vim.lsp.buf.implementation, opts)
map('n', 'K', vim.lsp.buf.hover, opts)

-- DAP
map('n', '<leader>db', ':DapToggleBreakpoint<CR>', opts)
map('n', '<leader>dc', ':DapContinue<CR>', opts)
map('n', '<leader>dt', ':DapTerminate<CR>', opts)

-- Windows
map('n', '<leader>ws', ':split<CR>', opts)
map('n', '<leader>wv', ':vsplit<CR>', opts)
map('n', '<leader>wh', '<C-w>h', opts)
map('n', '<leader>wj', '<C-w>j', opts)
map('n', '<leader>wk', '<C-w>k', opts)
map('n', '<leader>wl', '<C-w>l', opts)

