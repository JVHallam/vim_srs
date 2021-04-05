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

function RotateFile( stateFilePath )
    let state = readfile( a:stateFilePath )

    let rotatedState = RotateArray( state )
    
    call writefile( rotatedState, a:stateFilePath )
endfunction

function RotateArray( array )
    let arrayCopy = copy( a:array )

    let arrayLength = len( arrayCopy )

    let finalIndex = arrayLength - 1

    let newHead = [ arrayCopy[finalIndex] ]

    let newTail = arrayCopy[0 : finalIndex - 1]

    let arrayCopy = newHead + newTail

    return arrayCopy
endfunction

function TearDownState( stateDirectory = "./temp" )
    " Delete the directory
    let flags = "rf"
    call delete( a:stateDirectory, flags )
endfunction
