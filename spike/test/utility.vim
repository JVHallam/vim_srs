function PrintErrors()
    for error in v:errors
        echo ""
        echo " ------------------------- "
        echo ""

        let lines = split(error, "\\.\\.")

        let messages = filter(lines, {ind, val -> val != "" })

        for line in lines
            echo "-> " . line
        endfor
    endfor
endfunction

function AssertFileDoesNotExist( filePath, customError )
    let doesFileExist = filereadable( a:filePath ) 
    call assert_false( doesFileExist, a:customError )
endfunction

function AssertFileExists( filePath, customError )
    let doesFileExist = filereadable( a:filePath ) 
    call assert_true( doesFileExist, a:customError )
endfunction

" The new lines keep fucking up, hence why assert_equalfile isn't being used
function AssertFilesEqual( expectedFile, actualFile, customMessage = "" )
    let expectedContent = readfile( a:expectedFile )
    let actualContent = readfile( a:actualFile )

    call assert_equal( expectedContent, actualContent, a:customMessage )
endfunction
