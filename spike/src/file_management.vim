" Setup the local temp directory, to hold sessions
function InitState(dir="temp", file="state")
    call InitStateDir(a:dir)
    call InitStateFile(a:dir, a:file)
endfunction

function InitStateDir(dir="temp")
    if( isdirectory( a:dir ) == v:false )
        let command = "mkdir " . a:dir
        call system(command)
    endif
endfunction

function InitStateFile(dir="temp", file="state")
    let path = a:dir . "/" . a:file

    if( filereadable(path) == v:false )
        call writefile([], path)
    endif
endfunction
