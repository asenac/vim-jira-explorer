if exists("b:current_syntax")
  finish
endif

syntax match JiraID #^\S*#

highlight default link JiraID Identifier

let b:current_syntax = 'jira_explorer'
