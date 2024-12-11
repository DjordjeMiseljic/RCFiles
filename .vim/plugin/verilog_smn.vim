" Vim plugin for display verilog instance name
" Version : 1.3
" Date    : 2021/09/11
" Author  : Terry <NOtanruiSPAM@21cn.com> (Please delete the NOSPAM)
" 
" Modification:
" V1.1      2021/09/10      The initial version.
" V1.3      2021/09/11      Fix some bugs and add the line number printed

if &cp || exists("g:loaded_verilog_smn")
    finish
endif
let g:loaded_verilog_smn = 1

let s:save_cpo = &cpo
set cpo&vim

" define the skip string
let s:skip_comments = 'synIDattr(synID(line("."), col("."), 0), "name") =~?'
    \. '"string\\|comment\\|doxygen\\|verilogComment"'

function! s:FindInstanceStyle()
    " record the current cursor position
    let old_pos = getpos('.') 

    " default style
    let find_instance    = 0

    " judge the current position whether in a instance with style = 1
    if find_instance == 0
        let find_block_start = 0
        let find_block_end   = 0
        let find_block_start = search('^\s*\<\(module\)\@!\w\+\>\_s*#\_s*(\_.*)\_s\+\w\+\_s*(\_.*)\s*;', 'bcW', s:skip_comments)

        if find_block_start > 0
            let find_block_end = search(')\_s*)\s*;', 'cWe', s:skip_comments)

            if old_pos[1] >= find_block_start && old_pos[1] <= find_block_end
                let find_instance = 1
                "echom "find style = 1"
            endif
        endif

        " restore the cursor position
        call setpos('.', old_pos)
    endif

    " judge the current position whether in a instance with style = 2
    if find_instance == 0
        let find_block_start = 0
        let find_block_end   = 0
        let find_block_start = search('^\s*\<\(module\)\@!\w\+\>\_s\+\w\+\_s*(\_.*)\s*;', 'bcW', s:skip_comments)

        if find_block_start > 0
            let find_block_end = search(')\_s*)\s*;', 'cWe', s:skip_comments)

            if old_pos[1] >= find_block_start && old_pos[1] <= find_block_end
                let find_instance = 2
                "echom "find style = 2"
            endif
        endif

        " restore the cursor position
        call setpos('.', old_pos)
    endif

    " return the style
    return find_instance
endfunction

function! s:ShowModuleName()
    " record the current cursor position
    let old_pos = getpos('.') 

    let style = s:FindInstanceStyle()

    if style == 0
        let flag = 'bW'
        call searchpair('module', '', 'endmodule', flag, s:skip_comments)

        let flag = 'ceW'
        call search('module\s\+\w\+', flag, s:skip_comments)

        let module_name = expand("<cword>")
        let module_line = getpos('.')[1]
        echom "module name = " . module_name . " (Line = ". module_line .")"
    elseif style == 1
        let flag = 'bW'
        let line = searchpair('#', '', ';', flag, s:skip_comments)

        let flag = 'bW'
        call search('\<\w\+\>\s\+', flag, s:skip_comments)
        let module_name = expand("<cword>")
        let module_line = getpos('.')[1]

        let flag = 'cW'
        call search('(', flag, s:skip_comments)

        let flag = 'W'
        call searchpair('(', '', ')', flag, s:skip_comments) 

        call search('\<\w\+\>\s*', flag, s:skip_comments)
        let instance_name = expand("<cword>")
        let instance_line = getpos('.')[1]

        echom "module name = " . module_name . " (Line = ". module_line .")" . ", instance name = " . instance_name . " (Line = ". instance_line .")"
    elseif style == 2
        " forward search ';'
        let flag = 'cW'
        call searchpos(';', flag, s:skip_comments)

        " backward search ')'
        let flag = 'bcW'
        call searchpos(')', flag, s:skip_comments)

        " backward search the matched '('
        let flag = 'bW'
        let line = searchpair('(', '', ')', flag, s:skip_comments)

        " backward search the module and instance name
        let flag = 'bW'
        call search('\<\w\+\>\s*', flag, s:skip_comments)
        let instance_name = expand("<cword>")
        let instance_line = getpos('.')[1]

        call search('\<\w\+\>\s\+', flag, s:skip_comments)
        let module_name = expand("<cword>")
        let module_line = getpos('.')[1]

        echom "module name = " . module_name . " (Line = ". module_line .")" . ", instance name = " . instance_name . " (Line = ". instance_line .")"
    endif

    " restore the cursor position
    call setpos('.', old_pos)
endfunction

" command
if !exists(":SMN")
    command! -narg=0 SMN :call s:ShowModuleName()
endif

let &cpo = s:save_cpo
unlet s:save_cpo
finish

" vim: set ff=unix et ft=vim nowrap :
