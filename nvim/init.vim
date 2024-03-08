set scrolloff=8
set number
set relativenumber
set tags=./tags,tags;$HOME
set list

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
colorscheme habamax

nnoremap pv :Vex<CR>
nnoremap <space><CR> :so %<CR>

nmap <c-k> :wincmd k<CR>
nmap <c-j> :wincmd j<CR>
nmap <c-h> :wincmd h<CR>
nmap <c-l> :wincmd l<CR>
