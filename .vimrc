source ~/github.com/cirias/vimrc/.vimrc.plug

" Global Settings {{{;

	" Clipboard
	set clipboard=unnamed,unnamedplus

	" Hybrid Line Number
	set number relativenumber

  set cursorline

	" Hightlight Search
	set hlsearch
	set incsearch

	" Syntax Highlight
	syntax on

	" Set indent
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2
	set expandtab

	" Write to file directly when ':w', not to create a new file and remove the old
	" one. Otherwise it will cause file watcher problem.
	set backupcopy=yes

	" Colorful
	colorscheme solarized
  let g:solarized_termcolors=256
	set background=dark

	" Shell
	" set shell=fish

" }}}


" Key Bindings {{{

  " Leader
  let mapleader = ","
  noremap \ ,

  " edit .vimrc.local quickly
  nnoremap <leader>ev :vsplit ~/github.com/cirias/vimrc/.vimrc<cr>

  " load .vimrc quickly
  nnoremap <Leader>sv :source $MYVIMRC<cr>

  " Mute Highlighting
  noremap <slient> <C-l> :<C-u>nohlsearch<CR><C-l>

  " Move line
  nnoremap - ddp
  nnoremap _ ddkP

  " git grep
  nnoremap <Leader>g :Ggrep<Space>

  " Select word
  nnoremap <space> viw
  vnoremap <space> <esc>

  " Exit insert mode quickly
  inoremap jk <esc>

  " Uppercase
  inoremap <C-u> <esc>viwUea

  " Terminal
  if exists(':tnoremap')
    tnoremap jk <C-\><C-n>
    tnoremap <C-[> <C-\><C-n>
  endif

  " Substitute the word under the cursor
  nnoremap <Leader>* :%s/\<<C-r><C-w>\>/

" }}}


" Plugin Configuration {{{;

" " fzf
" " Command for git grep
" " - fzf#vim#grep(command, with_column, [options], [fullscreen])
" command! -bang -nargs=* GGrep
  " \ call fzf#vim#grep(
  " \   'git grep --line-number '.shellescape(<q-args>), 0,
  " \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Tabular
let g:tabular_loaded = 1

" " syntastic
" let g:syntastic_cpp_checkers = ['cppcheck', 'cpplint']
" let g:syntastic_cpp_cpplint_exec = 'cpplint'
" let g:syntastic_cpp_cppcheck_args = ['--language=c++']

" let g:syntastic_javascript_checkers=['eslint']

" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" deoplete
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('sources', {
" \ 'typescript': ['ale'],
" \ 'rust': ['ale'],
" \})

" " ale
" " let g:ale_completion_enabled = 1
" let g:ale_completion_autoimport = 1
" " ale does not support typescript-eslint so far
" let g:ale_linters = {
" \   'typescript': ['tsserver', 'eslint'],
" \   'rust': ['analyzer'],
" \}
" let g:ale_fixers = {
" \   'rust': ['rustfmt'],
" \}
" let g:ale_rust_analyzer_config = {
" \   'diagnostics': { 'disabled': ['unresolved-import'] },
" \   'cargo': { 'allFeatures': 1, 'loadOutDirsFromCheck': v:true },
" \   'procMacro': { 'enable': v:true }
" \}

" let g:ale_fix_on_save = 1
" let g:ale_rust_rustfmt_options = '--edition 2018'

" " haskellmode
" let g:haddock_browser="/usr/bin/google-chrome-stable"

" nerdcommenter
let NERDSpaceDelims=1

" " ctrlp
" let g:ctrlp_user_command = {
  " \ 'types': {
    " \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    " \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  " \ },
  " \ 'fallback': 'find %s -type f'
" \ }

" " ctrlp-funky
" nnoremap <Leader>fu :CtrlPFunky<Cr>
" " narrow the list down with a word under cursor
" nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" Markdown
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'typescript', 'go']


" " vim-flow
" let g:flow#enable = 0

" vim-prettier
let g:prettier#autoformat = 0
augroup for_prettier
  autocmd!
  autocmd BufWritePre *.json,*.js,*.jsx,*.ts,*.tsx Prettier
augroup END

let g:prettier#config#print_width = 110
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'

" }}}


" File settings {{{

" augroup filetype_cpp
  " autocmd!
  " " vim-clang-format
  " autocmd FileType c ClangFormatAutoDisable
  " autocmd FileType cpp ClangFormatAutoDisable
" augroup END

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_go
  autocmd!
  " autocmd BufWritePost *.go silent! !gofmt -w %
  " autocmd BufWritePost * edit
augroup END

" augroup filetype_rust
  " autocmd!
  " autocmd FileType rust nmap <buffer> <C-]> <Plug>(ale_go_to_definition)
  " autocmd FileType rust nmap <buffer> gh <Plug>(ale_hover)
" augroup END

" autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript

" augroup filetype_typescript
  " autocmd!

  " " HerringtonDarkholme/yats.vim
  " " mhartington/nvim-typescript 
  " " autocmd FileType typescript nmap <buffer> <leader>r :TSRefs<cr>
  " " autocmd FileType typescript nmap <buffer> <leader>t :TSType<cr>
  " " autocmd FileType typescript nmap <buffer> <leader>td :TSTypeDef<cr>
  " autocmd FileType typescript nmap <buffer> <C-]> <Plug>(ale_go_to_definition)
  " autocmd FileType typescript nmap <buffer> gh <Plug>(ale_hover)

  " " autocmd FileType typescript nmap <buffer> <Leader>ds :TSDefPreview<cr>

  " " autocmd FileType typescript nmap <buffer> <Leader>e :TSRename<cr>

  " " autocmd FileType typescript nmap <buffer> <Leader>ec :TSEditConfig<cr>

" augroup END

" augroup filetype_javascript
  " autocmd!
  " " Strip whitespace
  " autocmd FileType javascript autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" augroup END

" autocmd BufWritePre * call StripTrailingWhitespace()

" }}}


" Functions {{{
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }}}

augroup global_autos
    autocmd!
    " Open quickfix/location list window once after :grep, mainly for :Ggrep
    autocmd QuickFixCmdPost [^l]* cwindow 20
    autocmd QuickFixCmdPost l*    lwindow 20
augroup END

" telescope {{{
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" }}}

" lspconfig {{{
lua << EOF
local lspconfig = require('lspconfig')
-- local lspconfig_util = require('lspconfig/util')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local shared_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
lspconfig.gopls.setup {
  on_attach = shared_on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
lspconfig.tsserver.setup {
  on_attach = shared_on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}
lspconfig.eslint.setup{}
lspconfig.tailwindcss.setup{
  on_attach = shared_on_attach,
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true,
      experimental = {
        classRegex = { "tw`([^`]*)`" }
      }
    }
  }
}
lspconfig.rust_analyzer.setup {
  on_attach = shared_on_attach,
}
EOF
" }}}
