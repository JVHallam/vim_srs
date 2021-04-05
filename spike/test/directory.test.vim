exec "source ./src/file_management.vim"
exec "source ./test/utility.vim"

let s:stateFilePath = "./temp/vimrun.state"

function DoesStateExist()
    call InitState()
    call AssertFileExists( s:stateFilePath, "State file couldn't be found" )
    call TearDownState()
endfunction

function DoesStateMatchExpected()
    " Run the command here
    call InitState()

    call assert_equalfile("./test/resources/DoesStateMatchExpected.txt", s:stateFilePath, "Expected file vs statefile")

    call TearDownState()
endfunction

function DoesRotatedMatchExpected()
    call InitState()

    call RotateFile( s:stateFilePath )

    call AssertFilesEqual("./test/resources/DoesRotatedMatchExpected.txt", s:stateFilePath, "Expected file vs state file")

    call TearDownState()
endfunction

function DoesTearDown()
    call InitState()

    call AssertFileExists( s:stateFilePath, "State file couldn't be found" )

    call TearDownState()

    call AssertFileDoesNotExist( s:stateFilePath, "State file was found" )
endfunction

function DoesRetrieveExercise()
    call InitState()

    let expectedExercises = [ "test_1" ]

    let retrievedExercises = RetrieveExercises( s:stateFilePath, 1 )

    call assert_equal( expectedExercises, retrievedExercises )

    call TearDownState()
endfunction

function DoesUseTemplateInit()
    let templatePath = "./test/resources/DoesUseTemplateInit.txt"

    call InitState("temp", "vimrun.state", templatePath)

    call AssertFilesEqual( "./temp/vimrun.state", templatePath )

    call TearDownState()
endfunction

function RetrieveExercises_FiveProvided_ThreeSelected()
endfunction

" ==================== Test Execution =================================

" call DoesTearDown()
" call DoesStateExist()
" call DoesRotatedMatchExpected()
" call DoesStateMatchExpected()
" call DoesRetrieveExercise()
call DoesUseTemplateInit()
