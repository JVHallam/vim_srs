" Setup the local temp directory, to hold sessions
function InitState(dir="temp", file="vimrun.state")
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

    let exerciseList = GetExerciseList()

    if( filereadable(path) == v:false )
        call writefile(exerciseList, path)
    endif
endfunction

function GetExerciseList()
    let exerciseDirPath = "./exercises"

    let exerciseList = readdir( exerciseDirPath )

    return exerciseList
endfunction
