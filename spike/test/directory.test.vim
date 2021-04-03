function DoesStateExist()
    let path = "../temp/vimrun.state"

    let doesFileExist = filereadable(path) 

    call assert_true( doesFileExist, "State file has not been created" )
endfunction

" ==================== Test Execution =================================
call DoesStateExist()
