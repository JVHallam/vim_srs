" Setup the local temp directory, to hold sessions
function InitState(dir="temp", file="vimrun.state", stateTemplatePath="")
    call InitStateDir(a:dir)
    call InitStateFile(a:dir, a:file, a:stateTemplatePath)
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

" Should probably be in it's own file
" Wanted exercise count => The amount of exercises that are going to be ran in the next session
" total exercise count => the total number of exercises available 
function CreateExerciseIndexArray( wantedExerciseCount, totalExerciseCount )
    let multiplier = a:totalExerciseCount / pow(2, a:wantedExerciseCount )

    " Create the initial array, increasing by the powers of 2
    let i = 0
    let array=[]
    while i < a:wantedExerciseCount
        " pow(2, i) can never go below 1. Therefore, offset it by -1
        let rawValue = ceil(pow(2, i) * multiplier) - 1
        let value = float2nr( rawValue )
        call add( array, value )
        let i = i + 1
    endwhile

    " All values in the sequence should be greater than the previous value
    " If there are any values that are equal to or below the previous value
    " Set it to be one above that value
    let i = 1
    while i < len( array )
        if( array[i - 1] >= array[i] )
            let array[i] = array[i - 1] + 1
        endif

        let i = i + 1
    endwhile

    return array
endfunction

function InitStateDir(dir="temp")
    if( isdirectory( a:dir ) == v:false )
        let command = "mkdir " . a:dir
        call system(command)
    endif
endfunction

function InitStateFile( dir, file, stateTemplatePath )
    let path = a:dir . "/" . a:file

    if( filereadable(path) == v:true )
        return
    endif

    let exerciseList = []

    if( a:stateTemplatePath != "" )
        let exerciseList = readfile( a:stateTemplatePath )
    else
        let exerciseList = GetExerciseList()
    endif

    call writefile(exerciseList, path)
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

