" after/plugin/sexp.vim - Sexp mappings for regular people
" Maintainer:   Tim Pope <code@tpope.net>

if exists("g:loaded_sexp_mappings_for_regular_people") || &cp
  finish
endif
let g:loaded_sexp_mappings_for_regular_people = 1

function! s:map_sexp_wrap(type, target, left, right, pos)
  execute (a:type ==# 'v' ? 'x' : 'n').'noremap'
        \ '<buffer><silent>' a:target ':<C-U>let b:sexp_count = v:count<Bar>exe "normal! m`"<Bar>'
        \ . 'call sexp#wrap("'.a:type.'", "'.a:left.'", "'.a:right.'", '.a:pos.', 0)'
        \ . '<Bar>silent! call repeat#set("'.a:target.'", v:count)<CR>'
endfunction

function! s:sexp_mappings() abort
  if !exists('g:sexp_loaded')
    return
  endif
  call s:map_sexp_wrap('e', 'cseb', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse(', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse)', '(', ')', 1)
  call s:map_sexp_wrap('e', 'cse[', '[', ']', 0)
  call s:map_sexp_wrap('e', 'cse]', '[', ']', 1)
  call s:map_sexp_wrap('e', 'cse{', '{', '}', 0)
  call s:map_sexp_wrap('e', 'cse}', '{', '}', 1)

  "I'm not sure about these mapping, but I'll leave them in for now
  nmap <buffer> <c-h>   <Plug>(sexp_move_to_prev_element_head)
  nmap <buffer> <c-l>   <Plug>(sexp_move_to_next_element_head)
  "nmap <buffer> Ge  <Plug>(sexp_move_to_prev_element_tail)
  "nmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  xmap <buffer> <c-h>   <Plug>(sexp_move_to_prev_element_head)
  xmap <buffer> <c-l>   <Plug>(sexp_move_to_next_element_head)
  "xmap <buffer> Ge  <Plug>(sexp_move_to_prev_element_tail)
  "xmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  omap <buffer> <c-h>   <Plug>(sexp_move_to_prev_element_head)
  omap <buffer> <c-l>   <Plug>(sexp_move_to_next_element_head)
  "omap <buffer> Ge  <Plug>(sexp_move_to_prev_element_tail)
  "omap <buffer> E   <Plug>(sexp_move_to_next_element_tail)

  nmap <buffer> <I  <Plug>(sexp_insert_at_list_head)
  nmap <buffer> >I  <Plug>(sexp_insert_at_list_tail)
  nmap <buffer> <f  <Plug>(sexp_swap_list_backward)
  nmap <buffer> >f  <Plug>(sexp_swap_list_forward)
  nmap <buffer> <e  <Plug>(sexp_swap_element_backward)
  nmap <buffer> >e  <Plug>(sexp_swap_element_forward)
  nmap <buffer> >(  <Plug>(sexp_emit_head_element)
  nmap <buffer> <)  <Plug>(sexp_emit_tail_element)
  nmap <buffer> <(  <Plug>(sexp_capture_prev_element)
  nmap <buffer> >)  <Plug>(sexp_capture_next_element)

  "Added a delete whole form:
  nmap <buffer> dsf ds)dW
  "Wrap form inside a form:
  nmap <leader>f ysaf<c-f>
  "Add form in visual mode:
  vmap <buffer> <leader>f S<c-f>
  vmap <buffer> <c-f> S<c-f>
  "Wrap element in form:
  nmap <buffer> <c-f> ysie<c-f>
  "My doc lookup:
  nmap <buffer> K "zyie:Eval (clojure.repl/doc <c-r>z)<cr>

  "Get clone:
  nmap <leader>c yiePa <esc><right>

  "A more convenient command for clojurescript integration
  command! Wiggie :Piggieback (weasel.repl.websocket/repl-env :ip "0.0.0.0" :port 9001)
  cabbrev wiggie Wiggie
endfunction

function! s:setup() abort
  augroup sexp_mappings_for_regular_people
    autocmd!
    execute 'autocmd FileType' get(g:, 'sexp_filetypes', 'lisp,scheme,clojure') 'call s:sexp_mappings()'
  augroup END
endfunction

if has('vim_starting') && !exists('g:sexp_loaded')
  au VimEnter * call s:setup()
else
  call s:setup()
endif
