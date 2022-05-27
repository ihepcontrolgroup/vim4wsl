" File              : .vimrc
" Author            : zhangzhao <zhangzhao@ihep.ac.cn>
" Date              : 27.04.2022
" Last Modified Date: 27.04.2022
" Last Modified By  : zhangzhao <zhangzhao@ihep.ac.cn>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             universal settings                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ts=4
set sw=4
set et
set lbr
set fo+=mB
set sm
set selection=inclusive
set mousemodel=popup
set nocompatible   " 去掉vi一致性模式，避免bug
set ttimeoutlen=0  " 降低fcitx插件的反应时间
set lazyredraw     " 延迟绘制（提升性能）
set fileformats=unix,dos
set clipboard=exclude:.*

" syntax support
syntax on
syntax enable

"将H和L设置为定位到行首和行尾
"设置一些常用映射
nnoremap H 0
nnoremap L $

"可视状态下，设置H和L功能与normal一致
vnoremap H 0
vnoremap L $

"d到行首或行尾
nnoremap dL d$
nnoremap dH d0

"c到行首或行尾
nnoremap cL c$
nnoremap cH c0

"y到行首或行尾
nnoremap yL y$
nnoremap yH y0

"x删除不保存到剪切板
nnoremap x "_x
nnoremap X "_X

"添加一行但不进插入模式
nnoremap <C-L> o<Esc>
nnoremap <C-H> O<Esc>

"swich window
nnoremap <silent> tt :ChooseWin<cr>

"回车快速搜索
" nnoremap <CR> gd

"n和N固定搜索位置
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

"快速上移下移一行
nnoremap K  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap J  :<c-u>execute 'move +'. v:count1<cr>

"v模式下快速上移下移多行
vnoremap <silent> J :m '>+1gv=gv<cr>gv
vnoremap <silent> K :m '<-2gv=gv<cr>gv

"避免进入Ex模式
nnoremap Q <Nop>

"U撤销撤销操作
nnoremap U <C-r>

"跳转到mark时，跳转到行列的具体位置
nnoremap ' `

"normal下;自动添加末尾分号
nnoremap ; $a;<ESC>

" set clipboard
" visual: Ctrl+c copy the selected area; normal: Ctrl+c copy a line
" defaut to use system clipboard
" set clipboard=unnamedplus
" nnoremap <C-c> "+Y
" vnoremap <C-c> "+y

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" 行列线设置
set cul
" set cuc

"智能高亮光标所在行
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set shortmess=atI      " 启动的时候不显示援助乌干达儿童的提示
set go=                " 不要图形按钮
set showcmd            " 输入的命令显示出来，看的清楚些

" 设置折叠
set foldenable            " 允许折叠
"autocmd FileType java,c,cpp
set foldmethod=syntax
set foldlevel=999999      " 默认开始不折叠
" autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" set foldlevel=99 " Open all folds

function! OnSpace()
    if foldlevel('.')
        if foldclosed('.') != -1
        else
            return 'za'
        endif
    else
        return "\<Space>"
    endif
            return 'zO'
endfunction
nnoremap <silent> <Space> @=(OnSpace())<CR>

"显示中文帮助
set encoding=UTF-8

"自动缩进风格
"set autoindent
set cindent "c语言风格的缩进

" Tab设置
"统一缩进为4
set softtabstop=4
set tabstop=4
set shiftwidth=4
"在行和段开始处使用制表符
set smarttab
set expandtab

" 显示行号
set number
" 历史记录数
set history=1000
" 搜索逐字符高亮
set hlsearch
set incsearch
"编码设置
set langmenu=zh_CN.UTF-8
set fileencodings=utf8,gb2312,gbk,gb18030;
set termencoding=utf-8
set helplang=cn
"总是显示状态行
set cmdheight=1

"文件类型检测设置
"侦测文件类型
filetype on
"为特定文件类型载入相关缩进文件
filetype indent on
autocmd FileType java,c,cpp set commentstring=//\ %s

" save global variables
set viminfo+=!
"带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" difine filetype
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript


"设置当文件被改动时自动载入
set autoread
"自动保存
set autowrite
set magic                   " 设置魔术
"在处理未保存或只读文件的时候，弹出确认
set confirm

"不要使用vi的键盘模式，而是vim自己的
set nocompatible
"去掉输入错误的提示声音
set noeb

"设置备份
"允许备份
set backup
" 保存时备份
set writebackup
" 备份文件地址，统一管理
set backupdir=~/.vim/tmp
" 备份文件扩展名
set backupext=.bak
" 禁用交换文件
set noswapfile
" 禁用undo文件
set noundofile
" 创建目录，并且忽略可能出现的警告
silent! call mkdir(expand('~/.vim/tmp'), "p", 0755)

"搜索忽略大小写
set ignorecase
set linespace=0
"增强模式中的命令行自动完成操作
set wildmenu
"使回格键（backspace）正常处理indent, eol, start等
set backspace=2
"可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
"通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
"在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
"高亮显示匹配的括号
set showmatch
"匹配括号高亮的时间（单位是十分之一秒）
set matchtime=2
"光标移动到buffer的顶部和底部时保持10行距离
set scrolloff=10

" display space character
set list
set listchars=tab:↳\ ,trail:·

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Define <F5>-<F8>mapping                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <F5> for undotree
nnoremap <silent><F5> :UndotreeToggle<CR>

" <F7> for nerd tree
nnoremap <silent><F7> :NERDTreeToggle<CR>

" <F8> for tagbar
nnoremap <silent><F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Define <F9>-<F12> mapping                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <F9> format Markdown
autocmd FileType markdown nnoremap <silent><F9> :Prettier<CR>

" <F10> format verilog
" autocmd FileType verilog_systemverilog nnoremap <silent><F10> :AsyncRun -save=1 -post=checktime -silent istyle $(VIM_FILEPATH) && rm $(VIM_FILEPATH).orig <CR>

" <F10> preview markdown
autocmd FileType markdown nnoremap <silent><F10> :MarkdownPreview<CR>

" <F11> format C
autocmd FileType c,cpp nnoremap <silent><F11> :ClangFormat<CR>
autocmd FileType c,cpp vnoremap <silent><F11> :ClangFormat<CR>

" <F12> jump to header (:A)
function! s:a(cmd)
    let name = expand('%:r')
    let ext = tolower(expand('%:e'))
    let sources = ['c', 'cc', 'cpp', 'cxx']
    let headers = ['h', 'hh', 'hpp', 'hxx']
    for pair in [[sources, headers], [headers, sources]]
        let [set1, set2] = pair
        if index(set1, ext) >= 0
            for h in set2
                let aname = name.'.'.h
                for a in [aname, toupper(aname)]
                    if filereadable(a)
                        execute a:cmd a
                        return
                    end
                endfor
            endfor
        endif
    endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')
nnoremap <silent><F12> :A<CR>
nnoremap <silent>\<F12> :AV<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 vim-plug                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
" indent line
Plug 'Yggdroot/indentLine'
" tpope'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
" pairs
Plug 'jiangmiao/auto-pairs'
" comment
Plug 'tyru/caw.vim'
" static checking
Plug 'dense-analysis/ale' ,{ 'for' : [ 'c', 'cpp', 'python', 'sh' ] }
" code syntax highlight
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
Plug 'justinmk/vim-syntax-extra',{ 'for': ['c', 'bison', 'flex', 'cpp'] }
" Plug 'vhda/verilog_systemverilog.vim',{ 'for': 'verilog_systemverilog' }
" Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ekalinin/Dockerfile.vim'
" code format
Plug 'rhysd/vim-clang-format',{ 'on': 'ClangFormat', 'for' : [ 'c', 'cpp' ] }
" quickly move
Plug 'psliwka/vim-smoothie'
Plug 'easymotion/vim-easymotion'
" git state
Plug 'airblade/vim-gitgutter'
" starup interface
Plug 'mhinz/vim-startify'
" enhance search
Plug 'junegunn/vim-slash'
" format with a common character
Plug 'junegunn/vim-easy-align'
" multiline selected
Plug 'mg979/vim-visual-multi',{'branch': 'master'}
" input
" Plug 'vim-scripts/fcitx.vim'
" number
Plug 'myusuf3/numbers.vim'
" show the context of the current buffer contents
Plug 'wellle/context.vim'
" statistics startup time
" Plug 'dstein64/vim-startuptime'
" enhance vim diff
Plug 'chrisbra/vim-diff-enhanced'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }, }
Plug 'junegunn/fzf.vim', {'on': ['Files', 'Rg'] }
" status line
Plug 'kshenoy/vim-signature'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" header
Plug 'alpertuna/vim-header'
" nerd tree and tagbar
Plug 'preservim/nerdtree',{ 'on':  'NERDTreeToggle' }
Plug 'preservim/tagbar',{ 'on': 'TagbarToggle' }
" highlight cursor word
Plug 'RRethy/vimss-illuminate'
" generate tags(ctags,global) automatically
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" snippets
Plug 'SirVer/ultisnips'
" code completion
Plug 'jayli/vim-easycomplete'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'sgur/vim-textobj-parameter'
Plug 'glts/vim-textobj-comment'
Plug 'tommcdo/vim-exchange'
" themes
Plug 'NLKNguyen/papercolor-theme'
" Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
" Plug 'jacoborus/tender.vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'cocopon/iceberg.vim'
" Plug 'junegunn/seoul256.vim'
" markdown
Plug 'godlygeek/tabular', { 'for': ['markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release --locked
        else
            !cargo build --release --locked --no-default-features --features json-rpc
        endif
    endif
endfunction
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production', 'for': 'markdown'}

" lastplace
Plug 'farmergreg/vim-lastplace'
" undotree
Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
" minimap
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
" sudo
Plug 'lambdalisue/suda.vim'
" disable search highlighting
Plug 'romainl/vim-cool'
" set paste mode
Plug 'roxma/vim-paste-easy'
" select the closest test object
Plug 'gcmt/wildfire.vim'
" shell commands
Plug 'skywind3000/asyncrun.vim'
" window switch
Plug 't9md/vim-choosewin', { 'on': 'ChooseWin' }
" fast fold
Plug 'Konfekt/FastFold'
" match highlight
Plug 'andymass/vim-matchup'
" command line completion
Plug 'gelguy/wilder.nvim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          settings after plug#end                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 在注释行之下新开一行时不要自动加注释,放在插件加载完成之后，以防被插件修改
augroup FORMATOPTIONS
  autocmd!
  autocmd filetype * set fo-=c fo-=r fo-=o " Disable continuation of comments to the next line
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plug settings                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indentline
let g:indentLine_char     = '┊'
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1  = "inc"

" number.vim
let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree', 'minimap']

" vim-surround
vmap " S"
vmap ] S]
vmap [ S]
vmap ' S'
vmap > S>
vmap < S>
vmap / S/
vmap ) S)
vmap ( S)
vmap } S}
vmap { S}

" vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" themes settings
set t_Co=256
set background=light
" 让背景，行号，状态栏背景透明
" set termguicolors
" highlight Normal guibg       = NONE
" highlight LineNr guibg       = NONE
" highlight SignColumn guibg   = NONE "设置标志列背景色
" highlight CursorLineNr guibg = NONE "设置当前高亮行的NUM列背景

" themes
" gruvbox
" let g:gitgutter_override_sign_column_highlight = 1
" let g:gruvbox_italic = 1
" let g:gruvbox_bold = 1
" let g:gruvbox_contrast_dark = 'hard'
" color gruvbox

" paper theme
" colorscheme Paper
" colorschemo gruvbox
colorscheme onedark
let g:airline_theme = 'tomorrow'

" ale
" let g:ale_linters = {
"            \   'c++': ['clang'],
"            \   'c': ['clang'],
"            \   'h': ['clang'],
"            \   'sh': ['shellcheck'],
"            \}
" let g:ale_linters_explicit =1
let g:ale_sign_column_always         = 1
let g:ale_set_highlights             = 0
let g:ale_sign_warning               = ''
let g:ale_lint_on_enter              = 1
let g:ale_sign_error                 = ''
let g:airline#extensions#ale#enabled = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_echo_msg_error_str         = 'E'
let g:ale_echo_msg_warning_str       = 'W'
let g:ale_echo_msg_format            = '[%linter%] %s [%severity%]'
" 禁用默认INSERT模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
let g:ale_lint_on_text_changed       = 'normal'
let g:ale_lint_on_insert_leave       = 1

" gtags && gutentags"
let g:gutentags_modules           = ['ctags', 'gtags_cscope']
let g:gutentags_ctags_executable  = '/usr/bin/ctags'
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
"gutentags搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root      = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile     = '.tags'
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir         = expand('~/.cache/tags')
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args  = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--extra=+q']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 增加cscope使用的快捷键(C-[和esc按键一致，可以直接esc+s进行查找)
" nnoremap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" nnoremap <C-[>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
" nnoremap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>
let g:gutentags_plus_nomap = 1
let g:gutentags_plus_switch = 1
noremap <C-[>s :GscopeFind s <C-R><C-W><cr>
noremap <C-[>g :GscopeFind g <C-R><C-W><cr>
noremap <C-[>c :GscopeFind c <C-R><C-W><cr>
noremap <C-[>t :GscopeFind t <C-R><C-W><cr>
noremap <C-[>e :GscopeFind e <C-R><C-W><cr>
noremap <C-[>f :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <C-[>i :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <C-[>d :GscopeFind d <C-R><C-W><cr>
noremap <C-[>a :GscopeFind a <C-R><C-W><cr>
noremap <C-[>z :GscopeFind z <C-R><C-W><cr>

" NerdTree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeShowHidden=1
" close the buffer when only NERDTree exits
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight              = 1
let g:cpp_class_scope_highlight                  = 1
let g:cpp_class_decl_highlight                   = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight        = 1
let g:cpp_concepts_highlight                     = 1

" airline
let g:airline_powerline_fonts                    = 1
let g:Powerline_symbols                          = 'fancy'

" fzf
nnoremap <C-f> :Files <CR>
nnoremap <C-g> :Rg    <CR>

" vim-header
let g:header_auto_add_header    = 0
let g:header_field_author       = 'chengsn'
let g:header_field_author_email = 'chengsn@ihep.ac.cn'

" vim-gitgutter
let g:gitgutter_sign_allow_clobber = 1

" context.vim
let g:context_add_mappings = 0

" tagbar
let g:tagbar_ctags_bin = '/usr/bin/ctags'

" smoothie
let g:smoothie_no_default_mappings = 1
silent! nmap <unique> <C-J> <Plug>(SmoothieDownwards)
silent! nmap <unique> <C-K> <Plug>(SmoothieUpwards)
silent! vmap <unique> <C-J> <Plug>(SmoothieDownwards)
silent! vmap <unique> <C-K> <Plug>(SmoothieUpwards)

" vim-markdown
let g:vim_markdown_folding_disabled    = 1
let g:vim_markdown_conceal             = 0
let g:vim_markdown_conceal_code_blocks = 0

" markdown-composer
" let g:markdown_composer_address = 127.0.0.1
" let g:markdown_composer_port    = 8080

" auto-pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '<':'>'}

" easycomplete
let g:easycomplete_diagnostics_enable = 0
let g:easycomplete_lsp_checking       = 0
let g:easycomplete_menu_skin = {
        \   "buf": {
        \      "kind":"羅",
        \      "menu":"[B]",
        \    },
        \   "snip": {
        \      "kind":"",
        \      "menu":"[S]",
        \    },
        \   "dict": {
        \      "kind":"",
        \      "menu":"[D]",
        \    },
        \   "tabnine": {
        \      "kind":"",
        \    },
        \ }
  let g:easycomplete_filetypes = {"r": {
        \ "whitelist": []
        \ }}
  let g:easycomplete_tabnine_config = {
        \ 'line_limit': 800,
        \ 'max_num_result': 5,
        \ }
  let g:easycomplete_lsp_type_font = {
        \ 'class': "",     'color': "",
        \ 'constant': "",  'constructor': "",
        \ 'enum': "",      'enummember': "",
        \ 'field': "料",    'file': '',
        \ 'folder': "",    'function': "ƒ",
        \ 'interface': "", 'keyword': "",
        \ 'snippet': "",   'struct': "פּ",
        \ 'text': "",      'typeparameter': "",
        \ 'variable': "",  'module':'',
        \ 'event': '',
        \ 'r':'', 't':'',
        \ 'f':'', 'c':'',
        \ 'u':'𝘶', 'e':'𝘦',
        \ 's':'פּ', 'v':'',
        \ 'i':'𝘪', 'm':'',
        \ 'p':'', 'k':'𝘬',
        \ 'o':"𝘰", 'd':'𝘥',
        \ 'l':"𝘭", 'a':"𝘢",
        \ }


" minimap
let g:minimap_width      = 8
let g:minimap_auto_start = 1

" suda
let g:suda_smart_edit = 1

" -------------------------------------------------------------------------------
"                               MarkdownPreview Config
" -------------------------------------------------------------------------------

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = '8080'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = 'previewMarkdown-${name}'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'

" choose-window
let g:choosewin_overlay_enable = 1

" -------------------------------------------------------------------------------
"                               vim-prettier Config
" -------------------------------------------------------------------------------

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 'auto'

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 'auto'

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'auto'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = ''

" cli-override|file-override|prefer-file
" default: 'file-override'
let g:prettier#config#config_precedence = 'file-override'

" always|never|preserve
" default: 'preserve'
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
" default: 'css'
" let g:prettier#config#html_whitespace_sensitivity = 'css'

" false|true
" default: 'false'
let g:prettier#config#require_pragma = 'false'

" Define the flavor of line endings
" lf|crlf|cr|all
" defaut: 'lf'
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')

" personal snippets
set runtimepath+=~/.vim/UltiSnips

" easy-motion
map f <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map fl <Plug>(easymotion-lineforward)
map fh <Plug>(easymotion-linebackward)
map f. <Plug>(easymotion-repeat)

" wilder
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

" choose-window
let g:choosewin_overlay_enable = 1
