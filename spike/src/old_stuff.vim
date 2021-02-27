" project => name of the modular_vimrun directory ( "insertion", "special", "etc" )
function SetupSingleSession( project )

    let filesString = globpath("resources/modular_vimrun/" . a:project, "*")
    let filesArray = split( filesString )

    " Grab the corresponding session file from temp/
    " incase the file doesn't already exist, save it as we read from it later
    execute 'e' "temp/" . a:project
    exec 'w'

    " Remove the last line in the file, so that it gets put to the top 
    execute line('$') . 'd'
    exec "w"

    " If the length of the temp file != count of number of files
    " Find the files that aren't already in there and put them in at the top
    let fileContents = readfile(expand("%:p"))
    for file in filesArray
        let fileIndex = index(fileContents, file)

        if ( fileIndex == -1 )
            exec "0 put =file"
        endif
    endfor

    " Remove some empty lines
    exec "g/^$/d"

    " Save
    exec "w"
endfunction

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

function FetchSession( project, exerciseCount )
    let wantedExercises = []
    let fileLines = readfile("temp/" . a:project)
    
    let wantedIndexes = CreateExerciseIndexArray( a:exerciseCount, len(fileLines) )

    for wantedIndex in wantedIndexes
        if( wantedIndex >= len( fileLines ) )
            break
        endif

        call add( wantedExercises, fileLines[ wantedIndex ] )
    endfor

    return wantedExercises
endfunction

function RunForOneDirectory( fileList, outputFileName )
    exec "e" a:outputFileName . ".vimrun"

    " put the first divider in, to top off the file
    exec "read" g:dividerPath

    for fileName in a:fileList
      " Jump to the end of the file
      let endOfFile = line('$')
      call cursor(l:endOfFile, 0)

      " put in the divider
      exec "read" g:dividerPath

      " put in the, above it
      exec "read" fileName

    endfor

    " Top 4 lines of the file are whitespace
    " Delete them
    exec "1,4 d"
    exec "w"
endfunction

