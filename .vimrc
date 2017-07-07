source ~/.vimrc.bundle


" Global Settings {{{;

	" Clipboard
	set clipboard=unnamed,unnamedplus

	" Line Number
	set relativenumber

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
	set background=dark
	colorscheme solarized

	" Shell
	" set shell=fish

" }}}


" Key Bindings {{{

  " Leader
  let mapleader = ","
  noremap \ ,

  " edit .vimrc.local quickly
  nnoremap <leader>ev :vsplit ~/.vimrc<cr>

  " load .vimrc quickly
  nnoremap <Leader>sv :source $MYVIMRC<cr>

  " Mute Highlighting
  noremap <slient> <C-l> :<C-u>nohlsearch<CR><C-l>

  " Move line
  nnoremap - ddp
  nnoremap _ ddkP

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
  endif

  " Substitute the word under the cursor
  nnoremap <Leader>* :%s/\<<C-r><C-w>\>/

" }}}


" Plugin Configuration {{{;

" syntastic
let g:syntastic_cpp_checkers = ['cppcheck', 'cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_cppcheck_args = ['--language=c++']

let g:syntastic_go_checkers = ['go']

let g:syntastic_javascript_checkers=['eslint']

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" deoplete
let g:deoplete#enable_at_startup = 1

" vim-go
let g:go_fmt_command = "goimports"

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
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'go']

" vim-clang-format
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable

" }}}


" File settings {{{

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_go
  autocmd!
  " vim-go
  autocmd FileType go nmap <buffer> <leader>r <Plug>(go-run)
  autocmd FileType go nmap <buffer> <leader>b <Plug>(go-build)
  autocmd FileType go nmap <buffer> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <buffer> <leader>c <Plug>(go-coverage)

  autocmd FileType go nmap <buffer> <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <buffer> <Leader>dt <Plug>(go-def-tab)

  autocmd FileType go nmap <buffer> <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)

  autocmd FileType go nmap <buffer> <Leader>gb <Plug>(go-doc-browser)

  autocmd FileType go nmap <buffer> <Leader>s <Plug>(go-implements)

  autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)

  autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-rename)

  " autocmd FileType go autocmd BufWritePost * :GoErrCheck
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
