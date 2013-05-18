set shell=/bin/bash

if has("autocmd")
    augroup open_vimrc
        au!
        au bufwritepost common.vim source $HOME/Dropbox/Programming/VimConfig/common.vim
    augroup END
endif

nmap <leader>v :tabedit $HOME/Dropbox/Programming/VimConfig/common.vim<CR>

" cd to directory of file I am working on
augroup change_directory
    au!
    au BufEnter * silent! lcd %:p:h
augroup END

set ffs=unix,dos,mac

" activate filetype plugins
syntax on
filetype plugin on
filetype indent on
set autoindent

" look and feel
colorscheme wombat
:set hlsearch

set tabstop=4
set shiftwidth=4
set expandtab

if has("gui_gtk2")
    set guifont=Monospace\ 11
elseif has("gui_macvim")
    set guifont=Ubuntu\ Mono:h14
elseif has("gui_win32")
    set guifont=Ubuntu\ Mono:h12
end

" Line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
set rnu

" remove button bar
set guioptions-=T

" pathogen
call pathogen#infect() 

" indent guides
augroup indent_guides
    au!
    au VimEnter * IndentGuidesEnable
augroup END

" nerdtree
ca <silent> nt NERDTree
ca <silent> ntc NERDTreeClose

"" automatically open and close the popup menu / preview window
augroup not_sure_what_this_does
    au!
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup END
set completeopt=menuone,menu,longest,preview

let g:xptemplate_key = '<S-space>'
let g:xptemplate_nav_cancel = '<C-Tab>'

" remove highlighting when done searching
nmap // :nohl<CR>

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" tab navigation bindings
imap <C-y> <esc>:tabnew<CR>
nmap <C-y> :tabnew<CR>

imap <C-l> <ESC>:tabn<CR>
imap <C-h> <ESC>:tabp<CR>

nmap <C-right> :tabn<CR>
nmap <C-left> :tabp<CR>
nmap <C-l> :tabn<CR>
nmap <C-h> :tabp<CR>

" copy current file
nmap <C-A> :%y+<CR>

" FSwitch bindings
nmap <C-f><C-space> :call FSwitch('%', 'tabnew')<CR>
imap <C-f><C-space> <ESC>:call FSwitch('%', 'tabnew')<CR>

" Caps fixes
nmap :Q :q
nmap :W :w
nmap :E :e
nmap :WQ :wq

" Tabs
nmap <Tab> :><CR>
nmap <S-Tab> :<<CR>
vmap <Tab> :><CR>gv
vmap <S-Tab> :<<CR>gv
imap <S-Tab> <C-d>

function! OpenScratch()
    tabnew
    set buftype=nofile
endfunction

" Open a scratch tab
nmap <C-s> :call OpenScratch()<CR>

" path browsing keys
augroup netrw_keys
    au!
    au FileType netrw call Netrw_key_mappings()
augroup END
function! Netrw_key_mappings()
    nunmap <buffer> -
    nnoremap <buffer> - /^\.\.\/$<CR>:e <cfile><CR>:nohl<CR>

    unmap <buffer> <CR>
    nnoremap <buffer> <CR> :e <cfile><CR>
endfunction

" My shitty clone of FSwitch
nmap <leader>f :call Switch()<CR>
function! Switch()
    if (&ft=='objc' || &ft=='objcpp')
        let extension = fnamemodify(bufname("%"), ":e")
        if (extension=="h")
            let $FILENAME=substitute(bufname("%"), "\.h$", ".m", "") 
            tabnew $FILENAME
        elseif (extension=="m")
            let $FILENAME=substitute(bufname("%"), "\.m$", ".h", "")
            tabnew $FILENAME
        endif
    endif
endfunction

" (WIP) for finding things in xcode projects
imap <D-O> <ESC>:call OpenXFindSearch()<CR>
nmap <D-O> :call OpenXFindSearch()<CR>
augroup xfind_keys
    au!
    au FileType xfind_search call XFind_key_mappings()
augroup END
function! XFind_key_mappings()
    nnoremap <buffer> <S-CR> :call XFindOverwrite()<CR>
    inoremap <buffer> <CR> <ESC>:call XFindOpenNewTab()<CR>
    nnoremap <buffer> <CR> :call XFindOpenNewTab()<CR>
    nnoremap <buffer> T :call XFindOpenInNewTab()<CR>
endfunction
function! OpenXFindSearch()
    10new
    set buftype=nofile
    set filetype=xfind_search
    startinsert
endfunction
function! XFindOpenNewTab()
    if line(".")==1
        let $INPUT=getline(1)
        :2
        silent normal 9999dd
        silent 1read !xfind $INPUT
        normal gg
    else
        let $INPUT=getline(".")
        :q
        tabnew $INPUT
    endif
endfunction
function! XFindOpenInNewTab()
    if line(".")!=1
        let $INPUT=getline(".")
        tabnew $INPUT
        tabprevious
    endif
endfunction
function! XFindOverwrite()
    if line(".")!=1
        let $INPUT=getline(".")
        :q
        :e $INPUT
    endif
endfunction

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" Set filetype for racket files
augroup racket_files
    au!
    au BufNewFile,BufRead *.rkt set filetype=scheme
augroup END
