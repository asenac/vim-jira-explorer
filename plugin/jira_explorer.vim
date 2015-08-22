" Define function once only
if exists('loaded_jira_explorer') || &cp
  finish
endif

let loaded_jira_explorer = 1

" Create commands
if !exists(":JiraExplorer")
  command JiraExplorer :call <SID>JiraExplorer()
endif

" JiraExplorer {{{1
function! <SID>JiraExplorer() abort
  let s:issue_list = jira#get_issues(1)

  silent bot 10new 'Jira Issue Explorer'

  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal modifiable
  setlocal noswapfile
  setlocal nowrap

  map <buffer> <silent> <cr> :call <SID>SelectIssue()<cr>
  map <buffer> <silent> q :bd!<cr>

  let s:issues = []
  for issue in s:issue_list
      call add(s:issues, issue.abbr . ' - ' . issue.menu)
  endfor

  silent! put! =s:issues

  unlet! s:issue_list
  unlet! s:issues

  setlocal nomodifiable
  normal gg
  set ft=jira_explorer
endfunction

" SelectIssue {{{1
function! <SID>SelectIssue()
  let s:line = getline('.')
  if strlen(s:line) == 0
    return
  endif

  call <SID>Reset()

  let s:issue = split(s:line)[0]
  let $CHANGELIST = s:issue
  let &titlestring = s:issue

endfunction

" Reset {{{1
function! <SID>Reset()
endfunction

"----------------------------------------------------------"
"call <SID>JiraExplorer()

" vim:ft=vim foldmethod=marker
