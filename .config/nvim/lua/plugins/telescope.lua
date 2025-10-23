-- -----------------------------
-- Telescope
-- -----------------------------
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup {
    defaults = {
        layout_config = { horizontal = { width = 0.9 } },
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
            i = {
                ["<C-o>"] = function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if entry.path then
                        vim.fn.jobstart({ "xdg-open", entry.path }, { detach = true })
                    else
                        print("No path to open")
                    end
                end
            }
        },
    },
    pickers = { find_files = { hidden = true } }
}
pcall(require('telescope').load_extension, 'fzf')

