let s:stateFilePath = "./temp/vimrun.state"

function DoesStateExist()
    " Run the command here

    let doesFileExist = filereadable(s:stateFilePath) 

    call assert_true( doesFileExist, "State file has not been created" )
endfunction

function DoesStateMatchExpected()
    " Run the command here

    call assert_equalfile("./test/resources/DoesStateMatchExpected.txt", s:stateFilePath, "Expected file vs statefile")
endfunction

" ==================== Test Execution =================================
call DoesStateExist()
call DoesStateMatchExpected()
