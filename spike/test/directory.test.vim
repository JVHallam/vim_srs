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

" ======================= TESTS TO TEST ============================

function RunRetrieveExercisesTest( templatePath, expectedPath, exerciseCount )

    call InitState("temp", "vimrun.state", a:templatePath)

    let actualExercises = RetrieveExercises( s:stateFilePath, a:exerciseCount )

    let expectedExercises = readfile( a:expectedPath )

    call assert_equal( expectedExercises, actualExercises )

    call TearDownState()

endfunction

function RetrieveExercises_OneProvidedOneSelected_OneReturned()
    let exerciseCount = 1
    let templatePath = "./test/resources/retrieve_exercises/RetrieveExercises_1_template.txt"
    let expectedPath = "./test/resources/retrieve_exercises/RetrieveExercises_1_expected.txt"

    call RunRetrieveExercisesTest( templatePath, expectedPath, exerciseCount )
endfunction

function RetrieveExercises_TwoProvidedOneSelected_OneReturned()
    let exerciseCount = 1
    let templatePath = "./test/resources/retrieve_exercises/RetrieveExercises_2_template.txt"
    let expectedPath = "./test/resources/retrieve_exercises/RetrieveExercises_2_expected.txt"

    call RunRetrieveExercisesTest( templatePath, expectedPath, exerciseCount )
endfunction

function RetrieveExercises_FourProvidedTwoSelected_TwoReturned()
    let exerciseCount = 2
    let templatePath = "./test/resources/retrieve_exercises/RetrieveExercises_3_template.txt"
    let expectedPath = "./test/resources/retrieve_exercises/RetrieveExercises_3_expected.txt"

    call RunRetrieveExercisesTest( templatePath, expectedPath, exerciseCount )
endfunction

function RetrieveExercises_FiveProvidedThreeSelected_ThreeReturned()
    let exerciseCount = 3
    let templatePath = "./test/resources/retrieve_exercises/RetrieveExercises_4_template.txt"
    let expectedPath = "./test/resources/retrieve_exercises/RetrieveExercises_4_expected.txt"

    call RunRetrieveExercisesTest( templatePath, expectedPath, exerciseCount )
endfunction

" ==================== Test Execution =================================

" call DoesTearDown()
" call DoesStateExist()
" call DoesRotatedMatchExpected()
" call DoesStateMatchExpected()
" call DoesRetrieveExercise()
" call DoesUseTemplateInit()

" call RetrieveExercises_OneProvidedOneSelected_OneReturned()
" call RetrieveExercises_TwoProvidedOneSelected_OneReturned()
" call RetrieveExercises_FourProvidedTwoSelected_TwoReturned()
" call RetrieveExercises_FiveProvidedThreeSelected_ThreeReturned()
