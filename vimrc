let mapleader = " "

set nocompatible
set number
set tabstop=2
set shiftwidth=2
set scrolloff=2
set sidescrolloff=8
set smartindent
set autoindent
set smoothscroll
set hlsearch
set hidden
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" vnoremap <leader>y :w !clip.exe<CR>
set imsearch=-1
set iminsert=0
set history=200
set mouse=a
set incsearch
filetype plugin indent on
runtime macros/matchit.vim
syntax on
set cursorline
set showcmd
set ruler
set laststatus=2
set termguicolors        
set makeprg=cmake\ --build\ build
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb18030
set tags=./tags;,tags;
set signcolumn=yes
" 启用折叠
set foldenable
" 设置折叠方法为缩进 (可选 marker, syntax, manual)
set foldmethod=manual
" 设置折叠层级，默认一般为1
set foldlevel=99
" 在左侧显示折叠标识
set foldcolumn=1
set timeoutlen=1000
set ttimeoutlen=10

"MyFunction
function! HelloWorld() abort
	:echo "Hello Vim"
endfunction

" FileSaved
set shortmess+=W

function! s:SaveWithMessage() abort
	silent write
	redraw
	echohl MoreMsg
	echo expand('%:t'). " saved meow~"
	echohl None
endfunction

command! W call <SID>SaveWithMessage()
nnoremap <silent> <leader>w :W<CR>

" ---------- 通用键位 ----------
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>h :nohlsearch<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" " 窗口移动
" nnoremap <silent> <C-h> <C-w>h
" nnoremap <silent> <C-j> <C-w>j
" nnoremap <silent> <C-k> <C-w>k
" nnoremap <silent> <C-l> <C-w>l

" split 管理
nnoremap <silent> <leader>sv :vsplit<CR>
nnoremap <silent> <leader>sh :split<CR>
nnoremap <silent> <leader>sq :close<CR>
nnoremap <silent> <leader>so :only<CR>

" terminal
nnoremap <silent> <leader>th :botright 12split <Bar> terminal ++curwin<CR>
nnoremap <silent> <leader>tv :botright vsplit <Bar> terminal ++curwin<CR>
tmap <Esc> <C-\><C-n>

" 搜索移动后保持目标居中
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
" Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'

call plug#end()

" ===== 更舒服的配色（内置）=====
colorscheme jellybeans
" colorscheme quiet
" colorscheme slate
" colorscheme gruvbox
set background=dark

" ----------sign------------
" m/        " 打开当前文件 marks 列表
" m?        " 打开所有文件 marks 列表
" m,        " 跳到下一个 mark
" m.        " 跳到上一个 mark
" m<space>  清空当前buffer的mark
" ---------- fzf ----------
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <leader>fr :Rg<Space>
nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>

" 诊断导航
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gD <Plug>(coc-declaration)

" 鼠标
nnoremap <silent> <C-LeftMouse> <Plug>(coc-definition)

" " rename / code action / format
" nmap <silent> <leader>rn <Plug>(coc-rename)
" nmap <silent> <leader>ca <Plug>(coc-codeaction)
" xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
" nmap <silent> <leader>qf <Plug>(coc-fix-current)

" hover
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute 'h ' . expand('<cword>')
  endif
endfunction

" 格式化 暂时禁用. 看git改动的时候特别烦
" nnoremap <silent> <leader>fo :call CocAction('format')<CR>
" xnoremap <silent> <leader>fo :<C-u>call CocAction('formatSelected')<CR>

" 保存时自动格式化
" autocmd BufWritePre *.c,*.cc,*.cpp,*.cxx,*.h,*.hpp call CocAction('format')

" 让错误不要太烦
" 悬停才看详细信息；平时只看 sign 和 location list
nnoremap <silent> <leader>dt :call CocAction('diagnosticToggle')<CR>
function! s:toggle_coc_outline() abort
	let l:winid = coc#window#find('cocViewId', 'OUTLINE')
	if l:winid == -1
		call CocActionAsync('showOutline', 1)
	else
		call coc#window#close(l:winid)
	endif
endfunction
nnoremap <silent> <leader>co :<C-u>call <SID>toggle_coc_outline()<CR>

" 当前函数/符号列表
nnoremap <silent> <leader>ss :CocList -I symbols<CR>
nnoremap <silent> <leader>sc :CocList commands<CR>

" ======================== coc-snippet ========================

" 手动展开 snippet
imap <C-l> <Plug>(coc-snippets-expand)

" visual 模式选择 placeholder
vmap <C-j> <Plug>(coc-snippets-select)

" visual 选中代码转 snippet
xmap <leader>x <Plug>(coc-convert-snippet)

" snippet 占位符跳转
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" Tab：优先正常缩进；在词后面时触发补全
inoremap <silent><expr> <TAB>
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

" Shift-Tab：退格
inoremap <silent><expr> <S-TAB>
      \ "\<C-h>"

" Ctrl-n / Ctrl-p：沿用 Vim 习惯选择补全项
inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#refresh()
inoremap <silent><expr> <C-p>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ "\<C-p>"

" Ctrl-j：专门负责 snippet 展开/跳到下一个占位符
imap <C-j> <Plug>(coc-snippets-expand-jump)
smap <C-j> <Plug>(coc-snippets-expand-jump)
inoremap <silent><expr> <C-k>
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev', [])\<CR>" :
      \ "\<C-k>"

" Enter：补全菜单可见时确认候选；否则正常换行
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! SnippetStatus() abort
  if !exists('*coc#rpc#ready') || !coc#rpc#ready()
    return ''
  endif
  try
    return coc#jumpable() ? 'SNIP' : ''
  catch /Plugin not ready/
    return ''
  catch
    return ''
  endtry
endfunction

" =============================================================

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_warning = '%{SnippetStatus()}'

" ---------- buffer ----------
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>

" ---------- quickfix / location list ----------
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
" nnoremap <silent> <leader>qo :copen<CR>
" nnoremap <silent> <leader>qc :cclose<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> <leader>lo :lopen<CR>
nnoremap <silent> <leader>lc :lclose<CR>

" augroup my_ui
"   autocmd!
"   autocmd VimEnter * ++nested colorscheme gruvbox
" augroup END

" ---------- NERDTree ----------
" nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" nnoremap <silent> <leader>tt :NERDTreeToggle<CR>
" nnoremap <silent> <leader>tf :NERDTreeFind<CR>
" nnoremap <silent> <leader>tr :NERDTreeFocus<CR>
" let NERDTreeShowHidden=0

" augroup my_nerdtree
"   autocmd!
"   autocmd VimEnter * NERDTree
"   " Exit Vim if NERDTree is the only window remaining in the only tab.
"   autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
"   " Close the tab if NERDTree is the only window remaining in it.
"   autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" augroup END


  " if executable('iconv') && filereadable('/mnt/c/Windows/System32/clip.exe')

  " function! CopyToWindowsClipboard(lines) abort
  "     let l:text = join(a:lines, "\r\n")
  "     call system('iconv -f utf-8 -t utf-16le | /mnt/c/Windows/System32/clip.exe', l:text)
  " endfunction

  " function! PasteFromWindowsClipboard() abort
  "     return system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -Command "Get-Clipboard"')
  " endfunction

  " " 可视模式复制选中内容
  " xnoremap <silent> <leader>y :<C-u>call CopyToWindowsClipboard(getline("'<", "'>"))<CR>

  " " 普通模式复制当前行
  " nnoremap <silent> <leader>yy :call CopyToWindowsClipboard([getline('.')])<CR>

  " " 普通模式复制整个文件
  " nnoremap <silent> <leader>ya :call CopyToWindowsClipboard(getline(1, '$'))<CR>

  " " 从 Windows 剪贴板粘贴到光标后
  " nnoremap <silent> <leader>p :put =PasteFromWindowsClipboard()<CR>

  " endif

" ===============================
" Cross-platform system clipboard
" Windows / WSL / Linux
" ===============================

function! s:IsWSL() abort
  if !has('unix')
    return 0
  endif

  if exists('$WSL_DISTRO_NAME') || filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
    return 1
  endif

  return system('uname -r') =~? 'microsoft'
endfunction


function! CopyToSystemClipboard(lines) abort
  let l:text = join(a:lines, "\n")

  " WSL -> Windows clipboard
  if s:IsWSL()
    let l:clip = '/mnt/c/Windows/System32/clip.exe'

    if executable('iconv') && filereadable(l:clip)
      call system('iconv -f UTF-8 -t UTF-16LE | ' . shellescape(l:clip), l:text)
      if v:shell_error == 0
        return
      endif
    endif
  endif

  " Native Windows Vim / GVim
  if has('win32') || has('win64')
    if executable('powershell.exe')
      call system(
            \ 'powershell.exe -NoProfile -Command "[Console]::InputEncoding=[Text.Encoding]::UTF8; $s=[Console]::In.ReadToEnd(); Set-Clipboard -Value $s"',
            \ l:text
            \ )
      if v:shell_error == 0
        return
      endif
    endif

    if executable('clip.exe')
      call system('clip.exe', l:text)
      if v:shell_error == 0
        return
      endif
    endif
  endif

  " Linux Wayland
  if executable('wl-copy')
    call system('wl-copy', l:text)
    if v:shell_error == 0
      return
    endif
  endif

  " Linux X11: xclip
  if executable('xclip')
    call system('xclip -selection clipboard', l:text)
    if v:shell_error == 0
      return
    endif
  endif

  " Linux X11: xsel
  if executable('xsel')
    call system('xsel --clipboard --input', l:text)
    if v:shell_error == 0
      return
    endif
  endif

  " Vim 自带剪贴板兜底
  try
    call setreg('+', a:lines, 'l')
    return
  catch
  endtry

  echohl ErrorMsg
  echom 'No usable system clipboard tool found. Install wl-clipboard, xclip, or xsel.'
  echohl None
endfunction


function! PasteFromSystemClipboard() abort
  " WSL <- Windows clipboard
  if s:IsWSL()
    let l:ps = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'

    if filereadable(l:ps)
      let l:out = system(
            \ shellescape(l:ps) .
            \ ' -NoProfile -Command "[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false; Get-Clipboard -Raw"'
            \ )
      if v:shell_error == 0
        return substitute(l:out, "\r", "", "g")
      endif
    endif
  endif

  " Native Windows
  if has('win32') || has('win64')
    if executable('powershell.exe')
      let l:out = system(
            \ 'powershell.exe -NoProfile -Command "[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false; Get-Clipboard -Raw"'
            \ )
      if v:shell_error == 0
        return substitute(l:out, "\r", "", "g")
      endif
    endif
  endif

  " Linux Wayland
  if executable('wl-paste')
    let l:out = system('wl-paste --no-newline')
    if v:shell_error == 0
      return l:out
    endif
  endif

  " Linux X11: xclip
  if executable('xclip')
    let l:out = system('xclip -selection clipboard -out')
    if v:shell_error == 0
      return l:out
    endif
  endif

  " Linux X11: xsel
  if executable('xsel')
    let l:out = system('xsel --clipboard --output')
    if v:shell_error == 0
      return l:out
    endif
  endif

  " Vim 自带剪贴板兜底
  try
    return getreg('+')
  catch
  endtry

  echohl ErrorMsg
  echom 'No usable system clipboard paste tool found.'
  echohl None

  return ''
endfunction


" 可视模式复制选中行
xnoremap <silent> <leader>y :<C-U>call CopyToSystemClipboard(getline("'<", "'>"))<CR>

" 普通模式复制当前行
nnoremap <silent> <leader>yy :call CopyToSystemClipboard([getline('.')])<CR>

" 普通模式复制整个文件
nnoremap <silent> <leader>ya :call CopyToSystemClipboard(getline(1, '$'))<CR>

" 从系统剪贴板粘贴到当前行下面
nnoremap <silent> <leader>p :put =PasteFromSystemClipboard()<CR>

" fugitive
nnoremap <silent> <leader>2 :diffget //2<CR>
nnoremap <silent> <leader>3 :diffget //3<CR>
nnoremap <silent> <leader>ga :Git add %<CR>


"--------netrw----------"
let g:netrw_banner=1 "是否开启顶端的提示栏

let g:netrw_preview   = 1
let g:netrw_liststyle = 1
" let g:netrw_winsize   = 30
let g:netrw_sort_by = "name"
let g:netrw_hide = 1
let g:netrw_list_hide= '^\.,.*\.swp$'

function! NetrwDeleteRecursive() abort
  let name = netrw#Call('NetrwGetWord')
  let name = substitute(name, '/$', '', '')

  if name ==# '.' || name ==# '..' || name ==# './' || name ==# '../'
    echo 'Refusing to delete .'
    return
  endif

  let dir = get(b:, 'netrw_curdir', getcwd())
  let path = fnamemodify(dir . '/' . name, ':p')

  " 普通文件：交给 netrw 原来的删除逻辑
  if !isdirectory(path)
    call netrw#Call('NetrwLocalRm', dir)
    return
  endif

  " 目录：自己递归删除
  if confirm('Delete directory recursively: ' . path . ' ?', "&Yes\n&No", 2) != 1
    return
  endif

  if delete(path, 'rf') != 0
    echoerr 'delete failed: ' . path
  else
    execute 'edit ' . fnameescape(dir)
  endif
endfunction

augroup my_netrw_delete
  autocmd!
  autocmd FileType netrw nnoremap <buffer> dr :<C-U>call NetrwDeleteRecursive()<CR>
augroup END

nnoremap <leader>e :<C-u>E<CR>
nnoremap <leader>E :<C-u>Re<CR>
