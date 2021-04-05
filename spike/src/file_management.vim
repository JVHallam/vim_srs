" Setup the local temp directory, to hold sessions
function InitState(dir="temp", file="vimrun.state")
    call InitStateDir(a:dir)
    call InitStateFile(a:dir, a:file)
endfunction

function RotateFile( stateFilePath )
    let state = readfile( a:stateFilePath )

    let rotatedState = RotateArray( state )
    
    call writefile( rotatedState, a:stateFilePath )
endfunction

function TearDownState( stateDirectory = "./temp" )
    " Delete the directory
    let flags = "rf"
    call delete( a:stateDirectory, flags )
endfunction

function RetrieveExercises( stateFilePath, exerciseCount )
   let exercises = readfile( a:stateFilePath ) 

   let finalIndex = a:exerciseCount - 1

   let wantedExercises = exercises[0:finalIndex]

   return wantedExercises
endfunction

" ======================== Stuff that shouldn't be public ====================

function InitStateDir(dir="temp")
    if( isdirectory( a:dir ) == v:false )
        let command = "mkdir " . a:dir
        call system(command)
    endif
endfunction

function InitStateFile(dir="temp", file="state")
    let path = a:dir . "/" . a:file

    if( filereadable(path) == v:false )
        let exerciseList = GetExerciseList()
        call writefile(exerciseList, path)
    endif
endfunction

function GetExerciseList()
    let exerciseDirPath = "./exercises"

    let exerciseList = readdir( exerciseDirPath )

    return exerciseList
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

