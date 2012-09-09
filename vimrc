"------------------------------------------------------------------------------
" ~/.vimrc
"
" Author: adedommelin 
" Last modified: Wed Aug 15, 2012 09:30AM
"
"------------------------------------------------------------------------------

syntax on
set background=light
set nopaste
set pastetoggle=<F11>
set visualbell
set expandtab
set tabstop=2
set shiftwidth=2
set incsearch
set path=.,/usr/include,/usr/local/include,,
set showcmd 
set showmode
set warn
set ve=block
set confirm


"" Auto-update 'Last modified:' on buffer modification
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()


"" Insert header from template 
function! InsertHeader()
  let template = $HOME . "/.vim/standard_header"
  let filename = expand("%:p")
  let username = $USER
  let i = 0
  for line in readfile(template)
    let line = substitute(line, "<file_name>", filename, "ge")
    let line = substitute(line, "<user>", username, "ge")
    call append(i, line)
    let i += 1
  endfor
  execute "normal! Go\<Esc>k"
endfun
inoremap <F1> <esc>:call InsertHeader()<cr>
vnoremap <F1> :call InsertHeader()<cr>
nnoremap <F1> :call InsertHeader()<cr>



"" Define custom statusline 
set laststatus=2
set statusline=%1*[%n:%3*%f\ %2*%M%1*]%4*%a%1*\ %2*%r%h%1*[%LL]%=%4*%y%3*[%1*%c%V,%l%3*\|%1*%p%%%3*\|%1*%P%3*]


"" Place cursor at the last known position when opening a file
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

"" Highlight redundant whitespaces at the end of the lines:
highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/


"" Firefox-like Tabs management
inoremap <C-t> <esc>:tabnew<cr>i
vnoremap <C-t> :tabnew<cr>
nnoremap <C-t> :tabnew<cr>
inoremap <C-p> <esc>:tabprevious<cr>i
vnoremap <C-p> :tabprevious<cr>
nnoremap <C-p> :tabprevious<cr>
inoremap <C-n> <esc>:tabnext<cr>i
vnoremap <C-n> :tabnext<cr>
nnoremap <C-n> :tabnext<cr>
inoremap <C-w> <esc>:tabclose<cr>i
vnoremap <C-w> :tabclose<cr>
nnoremap <C-w> :tabclose<cr>


"" Line numbering
nmap <C-l> :set invnumber<CR>


"" Add some shortcuts for comments 
map ,# :s/^/#/<CR> <Esc>:nohlsearch <CR>
map ,/ :s/^/\/\//<CR> <Esc>:nohlsearch <CR>
map ," :s/^/\"/<CR> <Esc>:nohlsearch<CR>
map ,; :s/^/;/<CR> <Esc>:nohlsearch<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR


"" Handy function to add section block
function! AddSection()
  let s:line=line(".")
  call setline(s:line,"#------------------------------------------------------------------------------")
  call append(s:line,"# ")
  call append(s:line+1,"#------------------------------------------------------------------------------")
  unlet s:line
  execute "normal! \<Esc>k"
endfun
inoremap <F2> <esc>:call AddSection()<cr>
vnoremap <F2> :call AddSection()<cr>
nnoremap <F2> :call AddSection()<cr>


"" Folding
set foldmethod=marker
syn match  t2tFoldMark '\({{{\|}}}\)$'
syn region t2tUserFold keepend transparent fold start='^%.\+{{{$' end='^%.*}}}$'
syn region t2tTitleFold    transparent fold start='^ *=[^=].*[^=]=\(\[[a-z0-9_-]*\]\)\=\s*$' end='\n\n\n\n'
syn region t2tNumtitleFold transparent fold start='^ *+[^+].*[^+]+\(\[[a-z0-9_-]*\]\)\=\s*$' end='\n\n\n\n'
imap fff # Section_Title {{{<CR><CR>#}}}}

""highlight OverLength ctermbg=red ctermfg=white guibg=#592929
""match OverLength /\%81v.\+/


