# Use Cases
These are pretty much state explanations, on what the program should do.
I'm writing these, to then create the resources, to then write Tests that test this implementation.

## Note:
Exercises advance by default, by design. 
By design, they will move along the file, slowing rotating from the front to the back.

Therefore, we should always be thinking of failure. Failure is when there's any real logic.

# Init state:

( DONE ) 
* When there's no state file: 
    * Create the state directory ( call it state )
    * Create the state file     ( call it vimrun.state )

( DONE )
* When there's no state file: 
    * We have a directory for exercises ( called "exercises" )
        * In it is 3 folders, one for each exercise

    * Creates the vimrun.state file

    * it puts the names ( in alpha numeric order ) of the directories, into the vimrun.state file

( DONE )
* We can rotate the contents of the file
    * The file already exists
    * We just take the exercise at the bottom, and put it to the top


* We can get a selection of exercises from the file
    * ( Assume the state file already exists )
    * getExericses( stateFile, exercise_count )
    * We get the expected exercises back from the file

    * We never get the same exercise twice

    * If the number's greater than the number of exercises in the file, just return the most we can

    * Tests:
        1 - * Provide with a state file that has 1 exercise, ask for 1, get one
        2 - * Provide with a state file that has 2 exercises, ask for 1, get the first one
        3 - * Provide with a state file that has 4 exercises, ask for 2, get the first one and the second one
        4 - * Provide with a state file that has 5 exercises, ask for 3, get the 1, 2, and 3
        5 - * Provide with a state file that has 10 exercises, ask for 3, get the 1, 2, and 5
        6 - * Provide with a state file that has 10 exercises, ask for 5, get the 1, 2, 3, 4, and 5
        7 - * Provide with a state file that has 20 exercises, ask for 5, get 1, 2, 3, 5, 10, or something of the like
        8 - * Provide with a state file that has 3 exercises, ask for 4, get the 3, no duplicates
        9 - * Provide with a state file with no exercises, ask for 1, get an empty array back


* When done:
    * State which exercises we failed, by name [ array ]
    * It rotates the file
    * It puts all of the failed ones to the top

    * It then prunes the file for duplicates ( Which there should be )

* We can state that an exercise failed
    * failed( exercise )
    * That exercise is then put at the top of the state file

    * Check that It's only in the file once

    * Try with all that's given, are failed

* Everything's unique:
    * After any file state operation, check that everything in the file is unique

* When there's a state file already, but new exercises add to the exercises directory, 
    * ( how to detect the new ones? Without adding duplicates )

# Stretch goals:
* An infinite play session?
    * I would like the option to play infinitely ( this could be done, outside of this module )
    * possible approach:
        * InitState
        * Ask for 5 exercises
        * Do the 5
        * State which ones passed / failed
        * It would then:
            * Add the failures in
            * Rotate the file

        * You would then ask for 5 more. The infinite play wouldn't be implemented in this module.

* We can state than an exercise succeeded
    * Succeeded( exercise name )
    * That does nothing, Maybe do something in the future?
