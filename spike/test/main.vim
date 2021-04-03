exec "source test/utility.vim"

" ======================
" Setting up any defaults
let g:outputFile = get(g:, 'outputFile', "ex_mode_output.txt")
" ======================

" redirect the ex output to a register
exec "redir >> " . g:outputFile
echo "Running... vimscript main"
echo "outputting to : " . g:outputFile

" ================
" Run the e2e tests

exec "source test/directory.test.vim"

" Check that the temp file exists

" ================

echo "Tests complete : "
call PrintErrors()

" stop the redirection
exec "redir END"
