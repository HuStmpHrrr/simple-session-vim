" vim: foldmethod=marker et sw=4 ts=4
" LOAD ME!
" ^ magic text to allow .vimrc to load up this file too.
"
" THIS FILE GOES INTO YOUR INDIVIDUAL PROJECT FOLDER!
"

function! s:opened_files()
    let l:ret = []
	py <<EOF
import vimutils
vimutils.let_vimrepr('l:ret', vimutils.list_opened_files())
EOF
    return l:ret
endfunction

function! SaveSession(sname)
    let l:files = s:opened_files()
    python <<EOF
import vimutils
files = vim.eval('l:files')
curbuf = vim.current.buffer.name
with open(vim.eval('a:sname'), 'w') as fd:
    for f in files:
        if os.path.isfile(f): fd.write('e {}\n'.format(vimutils.raw_textrepr(f)))
    fd.write('if filereadable(' + vimutils.vimrepr(curbuf) + ')\n')
    fd.write('    b {}\n'.format(vimutils.raw_textrepr(curbuf)))
    fd.write('endif\n')
del fd
del curbuf
del files
EOF
endfunction
function! DeleteSession()
    if exists('s:session_name') && filereadable(s:session_name)
        call delete(s:session_name)
    endif
endfunction
function! SaveOnLeave(save)
    let g:save_on_leave = a:save
endfunction

let g:save_on_leave = 1
let s:session_name = '.session.vim'

execute 'autocmd quitpre * if g:save_on_leave|call SaveSession("'.s:session_name.'")|else|call DeleteSession()|endif'
execute 'if filereadable("'.s:session_name.'")|silent source '.s:session_name.'|endif'

