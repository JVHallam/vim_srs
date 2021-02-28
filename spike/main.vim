exec "source src/file_management.vim"

" ======================
" Required to be set via the main.ps1 script
" outputFile => the file path to the file that will have all ex output redirected to it
" ======================
" ======================
" Setting up any defaults
let g:outputFile = get(g:, 'outputFile', "ex_mode_output.txt")

" ======================

" redirect the ex output to a register
exec "redir >> " . g:outputFile
echo "Running... vimscript main"
echo "outputting to : " . g:outputFile

call InitState("temp")

" stop the redirection
exec "redir END"
