-- koda: dark monochrome colorscheme
-- Palette based on the "Koda Palette Dark Monochrome" from SalarAlo/dotfiles (kitty)

-- Follows 'background': dark by default, light when the terminal is light
-- (Neovim detects this automatically from iTerm2).

local light = vim.o.background == "light"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "koda"

local dark_palette = {
  bg      = "NONE",     -- use the terminal background (iTerm2 theme)
  bg_alt  = "#101010",  -- floats, popups
  bg_hl   = "#1a1a1a",  -- cursorline, selection, statusline
  bg_hl2  = "#262626",
  border  = "#2a2a2a",
  black   = "#000000",
  g1      = "#3d3d3d",  -- comments-ish, line numbers
  g2      = "#4a4a4a",
  g3      = "#5c5c5c",
  g4      = "#707070",
  g5      = "#848484",
  fg      = "#a6a6a6",  -- main text
  fg2     = "#b8b8b8",
  fg3     = "#d0d0d0",
  white   = "#e0e0e0",
  -- muted accents, only for things that must stand out
  red     = "#b07a7a",
  yellow  = "#bfb38a",
  green   = "#8fa58f",
  blue    = "#8496a9",
  diff_add = "#1a201a", diff_change = "#1c1c1c", diff_del = "#201a1a", indent = "#1c1c1c",
}

-- Same roles, inverted: "white" = strongest text, "black" = deepest background
local light_palette = {
  bg      = "NONE",
  bg_alt  = "#e8e8e8",
  bg_hl   = "#e2e2e2",
  bg_hl2  = "#d4d4d4",
  border  = "#cccccc",
  black   = "#f2f2f2",
  g1      = "#bdbdbd",
  g2      = "#a8a8a8",
  g3      = "#8a8a8a",
  g4      = "#707070",
  g5      = "#5a5a5a",
  fg      = "#3a3a3a",
  fg2     = "#2a2a2a",
  fg3     = "#1c1c1c",
  white   = "#0a0a0a",
  red     = "#9a5252",
  yellow  = "#7f6e30",
  green   = "#4f7050",
  blue    = "#466282",
  diff_add = "#dde8dd", diff_change = "#e4e4e4", diff_del = "#eedcdc", indent = "#e0e0e0",
}

local c = light and light_palette or dark_palette

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
  -- Editor
  Normal        = { fg = c.fg, bg = c.bg },
  NormalNC      = { fg = c.fg, bg = c.bg },
  NormalFloat   = { fg = c.fg, bg = c.bg_alt },
  FloatBorder   = { fg = c.border, bg = c.bg_alt },
  FloatTitle    = { fg = c.white, bg = c.bg_alt, bold = true },
  Cursor        = { fg = c.black, bg = c.white },
  CursorLine    = { bg = c.bg_hl },
  CursorColumn  = { bg = c.bg_hl },
  ColorColumn   = { bg = c.bg_hl },
  LineNr        = { fg = c.g1 },
  CursorLineNr  = { fg = c.fg3, bold = true },
  SignColumn    = { bg = c.bg },
  FoldColumn    = { fg = c.g1, bg = c.bg },
  Folded        = { fg = c.g4, bg = c.bg_hl },
  VertSplit     = { fg = c.border },
  WinSeparator  = { fg = c.border },
  EndOfBuffer   = { fg = c.bg_hl },
  NonText       = { fg = c.g1 },
  Whitespace    = { fg = c.g1 },
  SpecialKey    = { fg = c.g2 },
  Visual        = { bg = c.bg_hl2 },
  VisualNOS     = { bg = c.bg_hl2 },
  Search        = { fg = c.black, bg = c.g5 },
  IncSearch     = { fg = c.black, bg = c.white },
  CurSearch     = { fg = c.black, bg = c.white },
  Substitute    = { fg = c.black, bg = c.fg2 },
  MatchParen    = { fg = c.white, bg = c.bg_hl2, bold = true },
  Pmenu         = { fg = c.fg, bg = c.bg_alt },
  PmenuSel      = { fg = c.white, bg = c.bg_hl2 },
  PmenuSbar     = { bg = c.bg_hl },
  PmenuThumb    = { bg = c.g2 },
  StatusLine    = { fg = c.fg, bg = c.bg_hl },
  StatusLineNC  = { fg = c.g3, bg = c.bg_hl },
  TabLine       = { fg = c.g4, bg = c.bg_hl },
  TabLineSel    = { fg = c.white, bg = c.bg_hl2 },
  TabLineFill   = { bg = c.bg },
  WinBar        = { fg = c.g4 },
  Title         = { fg = c.white, bold = true },
  Directory     = { fg = c.fg2 },
  Question      = { fg = c.fg3 },
  MoreMsg       = { fg = c.fg3 },
  ModeMsg       = { fg = c.fg3 },
  ErrorMsg      = { fg = c.red },
  WarningMsg    = { fg = c.yellow },
  WildMenu      = { fg = c.white, bg = c.bg_hl2 },
  SpellBad      = { undercurl = true, sp = c.red },
  SpellCap      = { undercurl = true, sp = c.yellow },

  -- Syntax: contrast comes from brightness and weight, not color
  Comment       = { fg = c.g3, italic = true },
  Constant      = { fg = c.fg2 },
  String        = { fg = c.g5 },
  Character     = { fg = c.g5 },
  Number        = { fg = c.fg2 },
  Boolean       = { fg = c.fg2, bold = true },
  Float         = { fg = c.fg2 },
  Identifier    = { fg = c.fg },
  Function      = { fg = c.white, bold = true },
  Statement     = { fg = c.fg3 },
  Keyword       = { fg = c.fg3, bold = true },
  Conditional   = { fg = c.fg3, bold = true },
  Repeat        = { fg = c.fg3, bold = true },
  Label         = { fg = c.fg3 },
  Operator      = { fg = c.g4 },
  Exception     = { fg = c.fg3, bold = true },
  PreProc       = { fg = c.g5 },
  Include       = { fg = c.fg3 },
  Define        = { fg = c.fg3 },
  Macro         = { fg = c.fg2 },
  Type          = { fg = c.fg2, italic = true },
  StorageClass  = { fg = c.fg3 },
  Structure     = { fg = c.fg2 },
  Typedef       = { fg = c.fg2 },
  Special       = { fg = c.fg2 },
  Delimiter     = { fg = c.g4 },
  SpecialComment= { fg = c.g4, italic = true },
  Underlined    = { underline = true },
  Todo          = { fg = c.black, bg = c.g5, bold = true },
  Error         = { fg = c.red },

  -- Treesitter
  ["@variable"]            = { fg = c.fg },
  ["@variable.builtin"]    = { fg = c.fg2, italic = true },
  ["@variable.parameter"]  = { fg = c.fg, italic = true },
  ["@variable.member"]     = { fg = c.fg },
  ["@property"]            = { fg = c.fg },
  ["@constant"]            = { fg = c.fg2 },
  ["@constant.builtin"]    = { fg = c.fg2, bold = true },
  ["@module"]              = { fg = c.fg2 },
  ["@string"]              = { fg = c.g5 },
  ["@string.escape"]       = { fg = c.fg2 },
  ["@function"]            = { fg = c.white, bold = true },
  ["@function.call"]       = { fg = c.fg3 },
  ["@function.builtin"]    = { fg = c.fg3 },
  ["@function.method"]     = { fg = c.white, bold = true },
  ["@function.method.call"]= { fg = c.fg3 },
  ["@constructor"]         = { fg = c.fg2 },
  ["@keyword"]             = { fg = c.fg3, bold = true },
  ["@keyword.return"]      = { fg = c.white, bold = true },
  ["@keyword.function"]    = { fg = c.fg3, bold = true },
  ["@type"]                = { fg = c.fg2, italic = true },
  ["@type.builtin"]        = { fg = c.fg2, italic = true },
  ["@punctuation"]         = { fg = c.g4 },
  ["@punctuation.bracket"] = { fg = c.g4 },
  ["@punctuation.delimiter"] = { fg = c.g4 },
  ["@operator"]            = { fg = c.g4 },
  ["@comment"]             = { link = "Comment" },
  ["@tag"]                 = { fg = c.fg3 },
  ["@tag.attribute"]       = { fg = c.fg, italic = true },
  ["@tag.delimiter"]       = { fg = c.g4 },
  ["@markup.heading"]      = { fg = c.white, bold = true },
  ["@markup.strong"]       = { bold = true },
  ["@markup.italic"]       = { italic = true },
  ["@markup.link"]         = { fg = c.fg2, underline = true },
  ["@markup.raw"]          = { fg = c.g5 },

  -- Diagnostics
  DiagnosticError          = { fg = c.red },
  DiagnosticWarn           = { fg = c.yellow },
  DiagnosticInfo           = { fg = c.blue },
  DiagnosticHint           = { fg = c.g5 },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = c.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint  = { undercurl = true, sp = c.g5 },

  -- Diff / git
  DiffAdd        = { bg = c.diff_add },
  DiffChange     = { bg = c.diff_change },
  DiffDelete     = { fg = c.red, bg = c.diff_del },
  DiffText       = { bg = c.bg_hl2 },
  GitSignsAdd    = { fg = c.g5 },
  GitSignsChange = { fg = c.g4 },
  GitSignsDelete = { fg = c.red },

  -- Telescope
  TelescopeNormal        = { fg = c.fg, bg = c.bg_alt },
  TelescopeBorder        = { fg = c.border, bg = c.bg_alt },
  TelescopePromptNormal  = { fg = c.white, bg = c.bg_hl },
  TelescopePromptBorder  = { fg = c.bg_hl, bg = c.bg_hl },
  TelescopePromptTitle   = { fg = c.black, bg = c.fg2, bold = true },
  TelescopePromptPrefix  = { fg = c.fg2 },
  TelescopePreviewTitle  = { fg = c.black, bg = c.g4, bold = true },
  TelescopeResultsTitle  = { fg = c.bg_alt, bg = c.bg_alt },
  TelescopeSelection     = { fg = c.white, bg = c.bg_hl2 },
  TelescopeSelectionCaret= { fg = c.white, bg = c.bg_hl2 },
  TelescopeMatching      = { fg = c.white, bold = true },

  -- nvim-tree
  NvimTreeNormal         = { fg = c.fg, bg = c.bg },
  NvimTreeNormalNC       = { fg = c.fg, bg = c.bg },
  NvimTreeWinSeparator   = { fg = c.border },
  NvimTreeRootFolder     = { fg = c.white, bold = true },
  NvimTreeFolderName     = { fg = c.fg2 },
  NvimTreeOpenedFolderName = { fg = c.white, bold = true },
  NvimTreeEmptyFolderName  = { fg = c.g4 },
  NvimTreeFolderIcon     = { fg = c.g5 },
  NvimTreeIndentMarker   = { fg = c.g1 },
  NvimTreeGitDirty       = { fg = c.yellow },
  NvimTreeGitNew         = { fg = c.green },
  NvimTreeGitDeleted     = { fg = c.red },
  NvimTreeSpecialFile    = { fg = c.fg3, underline = true },

  -- Dashboard (alpha)
  AlphaHeader   = { fg = c.g5 },
  AlphaButtons  = { fg = c.fg },
  AlphaShortcut = { fg = c.g4 },
  AlphaFooter   = { fg = c.g3, italic = true },

  -- which-key
  WhichKey          = { fg = c.white },
  WhichKeyGroup     = { fg = c.fg2 },
  WhichKeyDesc      = { fg = c.fg },
  WhichKeySeparator = { fg = c.g3 },
  WhichKeyNormal    = { bg = c.bg_alt },
  WhichKeyBorder    = { fg = c.border, bg = c.bg_alt },

  -- Indent guides
  IblIndent = { fg = c.indent },
  IblScope  = { fg = c.g1 },

  -- Lazy
  LazyNormal = { fg = c.fg, bg = c.bg_alt },
  LazyButtonActive = { fg = c.black, bg = c.fg2, bold = true },
}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal colors (match the iTerm2 Fog / Fog-Light palettes)
local term = light and {
  "#2e2e2e", "#9a5252", "#4f7050", "#7f6e30", "#466282", "#735a80", "#3f7575", "#8a8a8a",
  "#6a6a6a", "#b06464", "#5f8560", "#95823a", "#56779a", "#876d95", "#4d8b8b", "#c4c4c4",
} or {
  "#000000", "#4a4a4a", "#5c5c5c", "#666666", "#707070", "#7a7a7a", "#848484", "#a6a6a6",
  "#3d3d3d", "#686868", "#a6a6a6", "#b0b0b0", "#b8b8b8", "#d0d0d0", "#c0c0c0", "#e0e0e0",
}
for i, col in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = col end

-- Expose palette for lualine
package.loaded["koda.palette"] = c
