#misc
alias whereami=pwd

alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias as_xml="xmllint --format --pretty 1 -"
alias as_json='python -m json.tool'
