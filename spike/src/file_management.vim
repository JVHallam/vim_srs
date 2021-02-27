" Setup the local temp directory, to hold sessions
function InitState(dir="temp", file="state")
    if( isdirectory( a:dir ) == v:false )
        let command = "mkdir " . a:dir
        call system(command)
    endif

    system("echo \"\" > " . a:file)
endfunction
