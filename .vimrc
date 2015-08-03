" vim: foldmethod=marker et sw=4 ts=4
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
        fd.write('e {}\n'.format(vimutils.raw_textrepr(f)))
    fd.write('if filereadable(' + vimutils.vimrepr(curbuf) + ')\n')
    fd.write('    b {}\n'.format(vimutils.raw_textrepr(f)))
    fd.write('endif\n')
del fd
del curbuf
del files
EOF
endfunction

let s:session_name = '.session.vim'

execute 'autocmd vimleavepre * call SaveSession("'.s:session_name.'")'
execute 'if filereadable("'.s:session_name.'")|silent source '.s:session_name.'|endif'
