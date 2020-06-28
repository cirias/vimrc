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

" fzf
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Tabular
" let g:tabular_loaded = 1

" syntastic
let g:syntastic_cpp_checkers = ['cppcheck', 'cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_cppcheck_args = ['--language=c++']

let g:syntastic_go_checkers = ['golint']

" let g:syntastic_javascript_checkers=['eslint']

" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
\ 'typescript': ['ale'],
\ 'rust': ['ale'],
\})

" vim-go
let g:go_fmt_command = "goimports"
" let g:go_def_mode = "godef"
let g:go_def_mode = "gopls"
" let g:go_updatetime = 800
" let g:go_auto_type_info = 1
" let g:go_metalinter_autosave = 1

" ale
" let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1
" ale does not support typescript-eslint so far
let g:ale_linters = {
\   'typescript': ['tsserver', 'eslint'],
\   'go': [],
\   'rust': ['analyzer'],
\}
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\}
let g:ale_rust_analyzer_config = {
\   'cargo': { 'allFeatures': 1 }
\}

let g:rustfmt_autosave = 1

" haskellmode
let g:haddock_browser="/usr/bin/google-chrome-stable"

" nerdcommenter
let NERDSpaceDelims=1

" ctrlp
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f'
\ }

" ctrlp-funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" Markdown
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'typescript', 'go']


" vim-flow
let g:flow#enable = 0

" deoplete-go
" let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

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

augroup filetype_cpp
  autocmd!
  " vim-clang-format
  autocmd FileType c ClangFormatAutoDisable
  autocmd FileType cpp ClangFormatAutoDisable
augroup END

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_go
  autocmd!
  " vim-go
  autocmd FileType go nmap <buffer> gh <Plug>(go-info)
  " autocmd FileType go nmap <buffer> <leader>r <Plug>(go-run)
  " autocmd FileType go nmap <buffer> <leader>b <Plug>(go-build)
  " autocmd FileType go nmap <buffer> <leader>t <Plug>(go-test)
  " autocmd FileType go nmap <buffer> <leader>c <Plug>(go-coverage)

  " autocmd FileType go nmap <buffer> <Leader>ds <Plug>(go-def-split)
  " autocmd FileType go nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
  " autocmd FileType go nmap <buffer> <Leader>dt <Plug>(go-def-tab)

  " autocmd FileType go nmap <buffer> <Leader>gd <Plug>(go-doc)
  " autocmd FileType go nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)

  " autocmd FileType go nmap <buffer> <Leader>gb <Plug>(go-doc-browser)

  " autocmd FileType go nmap <buffer> <Leader>s <Plug>(go-implements)

  " autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)

  " autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-rename)

  " autocmd FileType go autocmd BufWritePost * :GoErrCheck
augroup END

augroup filetype_rust
  autocmd!
  autocmd FileType rust nmap <buffer> <C-]> <Plug>(ale_go_to_definition)
  autocmd FileType rust nmap <buffer> gh <Plug>(ale_hover)
augroup END

autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript

augroup filetype_typescript
  autocmd!

  " HerringtonDarkholme/yats.vim
  " mhartington/nvim-typescript 
  " autocmd FileType typescript nmap <buffer> <leader>r :TSRefs<cr>
  " autocmd FileType typescript nmap <buffer> <leader>t :TSType<cr>
  " autocmd FileType typescript nmap <buffer> <leader>td :TSTypeDef<cr>
  autocmd FileType typescript nmap <buffer> <C-]> <Plug>(ale_go_to_definition)
  autocmd FileType typescript nmap <buffer> gh <Plug>(ale_hover)

  " autocmd FileType typescript nmap <buffer> <Leader>ds :TSDefPreview<cr>

  " autocmd FileType typescript nmap <buffer> <Leader>e :TSRename<cr>

  " autocmd FileType typescript nmap <buffer> <Leader>ec :TSEditConfig<cr>

augroup END

augroup filetype_javascript
  autocmd!
  " Strip whitespace
  autocmd FileType javascript autocmd BufWritePre <buffer> call StripTrailingWhitespace()
augroup END

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
