#Student Directory

##General Description

The student directory is a fully functional ruby script for managing the list of students enrolled in different courses (aka "cohorts") at Makers Academy.

The purpose of this script is to enable users to create a list of enrolled students, add various details about them (first name, last name, cohort month & cohort year), edit and remove entries as needed, as well as load & save the list in an independent csv file.

This version was written (mostly) according to TDD methodology.


##Application & Testing

The program runs in terminal (ruby must be installed).

To run in terminal: 
 	$ irb
 	$ require './lib/studentDirectory.rb'
	$ program_startup

To run the tests:
	$ rspec

(Rspec version: 3.0.3)


##Functional Description

When first running the program, the list of students will automatically be loaded from the relevant csv file if the latter exists (see "Save student List" & "Load student list" below for more details). 

If the file doesn't exit - the program creates a new file automatically in the same folder and notifies the user.

Similarly, if the file exists, but contains no data - an appropriate prompt is given to the user.

At the next stage, the user is presented with a main menu containing the following options:

1. Add new students to list

2. Show list of students

3. Clear list of student

4. Load list of students

5. Save list of students

6. Edit student details

7. Delete student from list 

9. Exit program

To select one of these options, the user needs to enter the relevant option-number and click "enter". 

Note that entering anything other than a legitimate option-number results in an "incorrect input" prompt asking the user to try again.


##Further Explanation on each Main Menu Item

###1. Add new students to list

When selecting this menu-option, the user is first asked to input the first name of the new student, followed by their last name, cohort month, and cohort year.

When the first or last names are entered without an initial capital letter, the initial letter of the name will be capitalized automatically.

The names on the list are automatically indexed and sorted alphabetically according to the students' first names (this operation takes place after each new name entry).

Inputting either an illegitimate month name or year will generate an "incorrect input" message followed by a prompt to the user to try again.

Note that uncapitalized month names are acceptable as input since they are capitalized automatically by the script.

If the user simply clicks "enter" without providing input about the student's Cohort Month or Cohort Year - they will be set to the current month/year by default.

To go back to the main menu, the user simply needs to click "enter" without entering a new name when prompted to add a new First Name for a student.


###2. Show list of students

After selecting this option, the user is asked to choose between three alternative presentation modes:

0. Complete student list

1. Filter student list by initial letter of first name - selecting this option will 

2. Filter student list by max number of letters in first name

As expected, selecting "0" will print the entire list to the terminal. 

If the user selects "1", s/he are then asked to enter a single letter by which to filter the student names.

Note that entering anything other than a single letter will result a prompt to the user to try again.

Also note that entering lower-case letters is acceptable since the input letter will automatically be capitalized.

If the user selects "2", s/he are asked to enter the maximum number of letters in a given name by which to filter the list (the maximum accepted number is limited to 100,000).

If the user enters anything other than an integer, they are asked to try again.

In each of the above presentation modes the student list includes:

- a header
- an indexed list of student names (sorted automatically in alphabetical order)
- a footer that quotes the overall number of students on the list (regardless of whether the list was filtered or not).


###3. Clear student list

Users can clear the current list of students by selecting this option.

The script will ask users to confirm this operation prior to execution.

In this context, the script is configured to accept various affirmative/negative answers from users (i.e. "Yes", "yes", "YES", "Y", "y" and their negative equivalents).


###4. Load student list

Users can manually load an existing list of students from a file (filename: “student_list.csv”).

The file is located in the same directory as the ruby script (see next menu item).

IMPORTANT: note that loading an existing list will OVERRIDE any changes that were made in the list during that particular session!  
(a warning prompt is given for this option and the user is asked for verification)


###5. Save student list

Users can save the current student list to a file (filename: "student_list.csv") which will be located in the same directory as the ruby script.

Note that if the file doesn't exist, it will be created automatically by saving the current list.

Also note that saving the file will automatically overwrite previous versions of the file if the latter already exists.


###6. Edit student details

Users can edit all the data elements associated with a given student.

After selecting this option, the user is presented with a complete student list and asked to select the relevant student.

(entering an illegitimate student-number results in an "incorrect input" prompt followed by a request that the student try again)

After selecting the student to be edited, the user is asked to select which data item they would like to edit (ie first name, last name, cohort month, or cohort year).


###7. Delete student from list

It is also possible to remove a student altogether from the list.

When selecting this option the users are presented with a complete list of the students. They are then asked to enter the student number from the list for deletion.

The program then asks users to confirm this operation prior to execution.

As before, the script is configured to accept various affirmative/negative answers from users (i.e. "Yes", "yes", "YES", "Y", "y" and their negative equivalents).


###9. Exit program

Selecting this menu-option will end the script and return the user to normal terminal mode.

Before exiting the script, users are asked if they would like to save the current list to a file (see: "Load file" & "Save file" options above).

As before, the script is configured to accept various affirmative/negative answers ("Yes", "yes", "YES", "Y", "y" and their negative equivalents).


##Notes

The modified script ("directory_2.rb") was put to the side, and the current version was written instead from scratch, mostly in the TDD approach as noted at the top of this document.

The original script (directory.rb) was re-written from scratch and re-named "directory_2.rb" - This was done to improve the structure of the code by making it more object-oriented (in contrast with the relatively linear structure of the original).

