set scrolloff=8
set number
set relativenumber
set tags=./tags,tags;$HOME
set list
set noswapfile
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

nmap <c-k> :wincmd k<CR>
nmap <c-j> :wincmd j<CR>
nmap <c-h> :wincmd h<CR>
nmap <c-l> :wincmd l<CR>

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp %!clang-format
