function! s:Filter_lines(cmd, filter)
	let save_more = &more
	set nomore
	redir => lines
	silent execute a:cmd
	redir END
	let &more = save_more
	new
	setlocal buftype=nofile bufhidden=hide noswapfile
	put =lines
	g/^\s*$/d
	%s/^\s*\d\+:\s*//e
	if !empty(a:filter)
		execute 'v/' . a:filter . '/d'
	endif
	0
endfunction
command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)
