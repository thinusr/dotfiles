local colors = {
  red         = '#BF616A',
  orange      = '#D08770',
  yellow      = '#EBCB8B',
  green       = '#A3BE8C',
  aqua        = '#8FBCBB',
  blue        = '#81A1C1',
  deep_blue   = '#5E81AC',
  purple      = '#B48EAD',
  bg_dark     = '#2E3440',
  bg_light    = '#3B4252',
  fg_light    = '#D8DEE9',
  fg_lighter  = '#ECEFF4',
}

local theme = {
  normal = {
    a = { fg = colors.fg_lighter, bg = colors.bg_dark },
    b = { fg = colors.fg_lighter, bg = colors.bg_light },
    c = { fg = colors.bg_dark, bg = colors.fg_light },
    z = { fg = colors.fg_lighter, bg = colors.bg_dark },
  },
  insert  = { a = { fg = colors.bg_dark, bg = colors.green } },
  visual  = { a = { fg = colors.bg_dark, bg = colors.orange } },
  replace = { a = { fg = colors.bg_dark, bg = colors.red } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.fg_lighter, bg = colors.fg_lighter } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then return '' end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then return '' end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then return '+' end
  if not vim.bo.modifiable or vim.bo.readonly then return '-' end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.fg_lighter } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.fg_lighter } },
      },
      { 'filename', path = 2 },
      { modified, color = { bg = colors.red } },
      { '%w', cond = function() return vim.wo.previewwindow end },
      { '%r', cond = function() return vim.bo.readonly end },
      { '%q', cond = function() return vim.bo.buftype == 'quickfix' end },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
  search_result,
  { 'encoding', color = { fg = colors.purple, gui = 'bold' } },
  { 'fileformat', color = { fg = colors.orange, gui = 'bold' } },
  'filetype',
},

    lualine_z = { '%l:%c', '%p%%/%L', function() return os.date("%H:%M") end },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}

