-- -----------------------------
-- Lualine
-- -----------------------------
require('lualine').setup({
    options = { theme = 'nord', section_separators = {'',''}, component_separators = {'|','|'} },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch','diff'},
        lualine_c = {'filename'},
        lualine_x = {'encoding','fileformat','filetype', function() return os.date("%H:%M") end },
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    inactive_sections = { lualine_c={'filename'}, lualine_x={'location'} },
})

-- Make Lualine transparent
vim.cmd [[highlight StatusLine guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight StatusLineNC guibg=NONE ctermbg=NONE]]
