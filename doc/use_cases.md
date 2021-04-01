# Use Cases
These are pretty much state explanations, on what the program should do.
I'm writing these, to then create the resources, to then write Tests that test this implementation.

## Note:
Exercises advance by default, by design. 
By design, they will move along the file, slowing rotating from the front to the back.

Therefore, we should always be thinking of failure. Failure is when there's any real logic.

# Init state:

* When there's no state file:
    * Create the state directory ( call it state )
    * Create the state file     ( call it vimrun.state )

* When there's no state file:
    * We have a directory for exercises ( called "exercises" )
        * In it is 3 folders, one for each exercise
        * In each folder is an exercise.vimrun file
    * Creates the vimrun.state file
    * it puts the names ( in alpha numeric order ) of the directories, into the vimrun.state file


* We can get a selection of exercises from the file
    * ( Assume the state file already exists )
    * getExericses( exercise_count )
    * We get the expected exercises back from the file

    * We never get the same exercise twice

    * If the number's greater than the number of exercises in the file, just return the most we can

    * It rotates the file as expected:
    * When we ask for exercises, it's got the one that WAS at the end of the file, now at the top of the file

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
    * It would require having a function that could run infinitely
    * It would 
        * generate an infinite series
        * That returns the same x numbers, in constant intervals

    * Holy shit, that'd be something interesting to have

* We can state than an exercise succeeded
    * Succeeded( exercise name )
    * That does nothing.
