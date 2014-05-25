require 'csv'


def program_startup

	print "\nMAKERS ACADEMY STUDENT DIRECTORY\n"
	load_list_from_file("student_list.csv")
	loop do
		print_main_menu
		user_menu_selection (get_input_from_user)
	end
end


def print_main_menu

	l1 = "Please select one of the following options:"
	l2 = "1. Add new students to list"
	l3 = "2. Show list of students"
	l4 = "3. Clear list of students"
	l5 = "4. Load list of students from file"
	l6 = "5. Save list of students to file"
	l7 = "6. Edit student details"
	l8 = "7. Delete student from list"
	l9 = "9. Exit"
	puts "#{l1}\n#{l2}\n#{l3}\n#{l4}\n#{l5}\n#{l6}\n#{l7}\n#{l8}\n#{l9}\n"
end


def user_menu_selection(user_input)

	file_name = "student_list.csv"
	case (user_input)	
		when ("1") then input_new_student
		when ("2") then print_student_list
		when ("3") then clear_student_list_query
		when ("4") then load_student_list_query("student_list.csv")
		when ("5") then save_list_to_file("student_list.csv")
		when ("6") then edit_student_details
		when ("7") then delete_student
		when ("9") then exit_program
		else incorrect_input_prompt
	end
end


def student_list 

	@student_list ||= []
end


def collect_student_details(first_name,last_name,cohort,year)

	first_name.capitalize!
	last_name.capitalize!
	if (last_name.empty?) 
		last_name = "[empty]"
	end
	if (cohort.empty?) 
		cohort = Time.now.strftime("%B")
	end
	if (year.empty?) 
		year = Time.now.strftime("%Y")
	end
	student_details = {
		first_name: first_name, 
		last_name: last_name, 
		cohort: cohort.to_sym, 
		year: year.to_i
	} 
	student_details
end


def add_student_to_list(student_details)

	if !student_details[:first_name].empty?
		student_list << student_details
		student_list.sort_by! {|student| student[:first_name]}
	end
end



def input_new_student

	first_name = get_first_name
	while !first_name.empty?
		last_name = get_last_name
		cohort = get_cohort
		if ((!is_month?(cohort)) && (!cohort.empty?))
			incorrect_input_prompt
			get_cohort
		end
		year = get_year
		if ((!is_year?(year.to_i)) && (!year.empty?))
			incorrect_input_prompt
			get_year	
		end
		student_details = collect_student_details(first_name, last_name, cohort, year)
		add_student_to_list(student_details)
		print_student_info(student_details)
		print_student_count
		first_name = get_first_name
	end	
end


def get_first_name

	print "\nPlease enter First Name:\n"
	print "(click return to go back to main menu)\n"
	gets.chomp
end


def get_last_name

	print "\nPlease enter Last Name:\n"
	gets.chomp
end


def get_cohort

	print "\nPlease enter Cohort Month:\n"
	print "(click 'enter' for current month)\n"
	gets.chomp
end


def get_year

	print "\nPlease enter Cohort Year:\n"
	print "(click 'enter' for current year)\n"
	gets.chomp
end


def print_student_info(student_details)

	print "\nNew student added to list: ["
	print "#{student_details[:first_name]} #{student_details[:last_name]} (#{student_details[:cohort]} #{student_details[:year]})"
	print "]\n\n"
end


def print_student_count

	student_count = student_list.length
	if (student_count == 0)
		print "\n(The list is currently empty)\n\n"
	elsif (@student_list == 1)
		print "\n(The list currently contains one student)\n\n"
	else
		print "\n(The list currently contains #{student_count} students)\n\n"
	end
end


def clear_student_list_query

	print "\nAre you sure you want to clear the current student list? (Yes/No)\n"
	user_input = gets.chomp
	if ((user_input == "Yes") || (user_input == "Y") || (user_input == "yes") || \
		(user_input == "y") || (user_input == "YES"))
		clear_student_list
		print "\nStudent list was cleared and is now empty.\n\n"
	elsif ((user_input == "No") || (user_input == "N") || (user_input == "no") || \
		(user_input == "n") || (user_input == "NO"))
		print "\nStudent list was not cleared.\n\n"
	else 
		incorrect_input_prompt
		clear_student_list_query
	end
end


def clear_student_list

	@student_list.clear
end


def load_list_from_file (file_name)

	if (File.file?(file_name))
		if (student_list.length != 0) 
			clear_student_list
		end
		file = File.open(file_name, "r")
		file.readlines.each do |line|
			first_name, last_name, cohort, year = line.chomp.split(',')
			student_list << {:first_name => first_name, :last_name => last_name, :cohort => cohort.to_sym, :year => year.to_i}
  		end
		file.close

		if (@student_list.length == 0)
			print "\nStudent list file is empty - No data was loaded.\n"
		else
			print "\nStudent list was loaded from file\n"
			print_student_count
			print "\n"
		end
	else
		file = File.open(file_name, "w")
		file.close
		print "\nStudent list file not found - New file created.\n\n"
	end
end


def save_list_to_file(file_name)

	file = File.open(file_name, "w")
	student_list.each do |student|
		student_data = [student[:first_name], student[:last_name], student[:cohort], student[:year]]
		csv_line = student_data.join(",")
		file.puts csv_line
	end
	file.close
	print "\nCurrent student list was saved to file.\n\n"
end


def get_input_from_user

	STDIN.gets.chomp
end


def incorrect_input_prompt

	print "\nSorry, incorrect input - Please try again.\n"
end


def save_before_exit_query

	print "\nWould you like to save changes in list before exiting? (Yes/No)\n"
	user_input = gets.chomp
	if ((user_input == "Yes") || (user_input == "Y") || (user_input == "yes") || \
		(user_input == "y") || (user_input == "YES"))
		save_list_to_file("student_list.csv")
	elsif ((user_input == "No") || (user_input == "N") || (user_input == "no") || \
		(user_input == "n") || (user_input == "NO"))
		print "\nCurrent student list was not saved to file.\n\n"
	else 
		incorrect_input_prompt
		save_before_exit_query
	end
end


def load_student_list_query(file_name)

	print "\nAre you sure you want to load the student list from file? (Yes/No)\n"
	print "(loading the list will OVERWRITE any changes in the list since last save)\n"
	user_reply = gets.chomp
	if ((user_reply == "Yes") || (user_reply == "Y") || (user_reply == "yes") || \
		(user_reply == "y") || (user_reply == "YES"))
		load_list_from_file(file_name)
	elsif ((user_reply == "No") || (user_reply == "N") || (user_reply == "no") || \
		(user_reply == "n") || (user_reply == "NO"))
		print "\nStudent list was not loaded from file.\n"
	else 
		incorrect_input_prompt
		load_student_list_query("file_name")
	end
end	


def print_student_list

	print "\nPlease select one of the following print options:\n" 

	print "0. Complete list\n" 

	print "1. Filter list by initial letter of first name\n" 

	print "2. Filter list by max number of letters in first name\n"

 	user_print_selection = gets.chomp

 	case (user_print_selection)

 		when ("0")
 				print_entire_list
 		when ("1")
 				filter_by_initial_letter
 		when ("2")
 				filter_by_number_of_letters
  		else
  			incorrect_input_prompt
 			print_student_list
 	end
end


def print_entire_list

	print_list_header
	print_all_students
	print_student_count
end


def print_all_students

	student_list.each.with_index(1) do |student, index|

		print "#{index}. #{student[:first_name]} #{student[:last_name]} (#{student[:cohort]} #{student[:year]})\n"
	end
end


def filter_by_initial_letter

	print "\nPlease type in a letter:\n" 

	filter_letter = gets.chomp

	filter_letter.capitalize!

	if !(("A".."Z") === filter_letter)

		incorrect_input_prompt
		filter_by_initial_letter
	end

	print_list_header

	selected_students = student_list.select {|student| student[:first_name].start_with?(filter_letter)}

	selected_students.each.with_index(1) do |student, index|
		print "#{index}. #{student[:first_name]} #{student[:last_name]} (#{student[:cohort]} #{student[:year]})\n"
	end

	print_student_count
end


def filter_by_number_of_letters

   	print "\nPlease input maximum number of letters in first name:\n"     

    filter_number = gets.chomp

   	if !(("1".."100000") === filter_number)

		incorrect_input_prompt
		filter_by_number_of_letters
	end

	print_list_header

	selected_students = student_list.select {|student| student[:first_name].length <= filter_number.to_i}

	selected_students.each.with_index(1) do |student, index|
		print "#{index}. #{student[:first_name]} #{student[:last_name]} (#{student[:cohort]} #{student[:year]})\n"
	end

	print_student_count
end


def print_list_header

	print "\n\nList of Students at Makers Academy\n"
	print "----------------------------------\n"
end


def is_month? (input_month)

	input_month.capitalize!
	if ((input_month == "January") || (input_month == "February") || (input_month == "March") ||\
		(input_month == "April") || (input_month == "May") || (input_month == "June") || \
		(input_month == "July") || (input_month == "August") || (input_month == "September") ||\
		(input_month == "October") || (input_month == "November") || (input_month == "December"))
		return true
	else
		return false
	end
end

def is_year? (input_year)

	if input_year.is_a? Fixnum
   		return true
   	else
   		return false
   	end
end


def file_available?(file_name)

	if File.file?(file_name)
		return true
	else
		return false
	end
end


def exit_program

	save_before_exit_query
	exit
end


def edit_first_name(student_number, new_data)

	student_list[student_number][:first_name] = new_data

end


def edit_last_name(student_number, new_data)

	student_list[student_number][:last_name] = new_data

end

def edit_cohort(student_number, new_data)

	student_list[student_number][:cohort] = new_data.to_sym
end


def edit_year(student_number, new_data)

	student_list[student_number][:year] = new_data.to_i
end


def edit_student_details

	print "\nCurrent list of students:\n\n"
	print_all_students
	student_number = (select_student_for_editing - 1)
	type_of_data = select_type_of_data_to_edit

	case (type_of_data)

		when ("new_first_name")
			print "\nPlease enter new first name:\n"
			new_first_name = gets.chomp
			new_first_name.capitalize!
			while (new_first_name.empty?)
				incorrect_input_prompt
				print "\nPlease enter new first name:\n"
				new_first_name = gets.chomp
				new_first_name.capitalize!
			end
			edit_first_name(student_number, new_first_name)	

		when ("new_last_name")
			print "\nPlease enter new last name:\n"
			new_last_name = gets.chomp
			new_last_name.capitalize!
			while (new_last_name.empty?)
				incorrect_input_prompt
				print "\nPlease enter new last name:\n"
				new_last_name = gets.chomp
				new_last_name.capitalize!
			end
			edit_last_name(student_number, new_last_name)

		when ("new_cohort")
			new_cohort = get_cohort
			while (!is_month?(new_cohort))
				if (new_cohort.empty?) 
					new_cohort = Time.now.strftime("%B")
				else
					incorrect_input_prompt
					new_cohort = get_cohort
				end
			end
			edit_cohort(student_number, new_cohort)
	
		when ("new_year")
			print "\nPlease enter new year:\n"
			print "(click 'enter' for current year)\n"
			new_year = gets.chomp
			while (new_year.to_i == 0)
				if (new_year == "")
					new_year = (Time.now.strftime("%Y")).to_s
				else	
	 				incorrect_input_prompt
					new_year = gets.chomp
				end
			end	
			edit_year(student_number, new_year)	
	end
	print_updated_student_details(student_number)
	student_list.sort_by! {|student| student[:first_name]}
end


def print_updated_student_details(student_number)

	print "\nstudent entey edited: "
	print "#{student_list[student_number][:first_name]} "
	print "#{student_list[student_number][:last_name]} "
	print "(#{student_list[student_number][:cohort]} "
	print "#{student_list[student_number][:year]})\n\n"
end


def select_student_for_editing

	print "\nPlease enter student number for editing:\n" 
	print "(click 'enter' to re-print student list)\n"

	student_count = student_list.length

	user_selection = gets.chomp

	if ((1..student_count) === user_selection.to_i)
		return user_selection.to_i
	elsif (user_selection == "")
		print "\nCurrent list of students:\n\n"
		print_all_students
		select_student_for_editing
	else
		incorrect_input_prompt
		select_student_for_editing
	end
end


def select_type_of_data_to_edit

	l1 = "Please select which information to edit:"
	l2 = "1. First name"
	l3 = "2. Last name"
	l4 = "3. Cohort"
	l5 = "4. Year"
	print "\n#{l1}\n#{l2}\n#{l3}\n#{l4}\n#{l5}\n"
	user_data_selection = gets.chomp
	case (user_data_selection)
 		when ("1") then return "new_first_name"
 		when ("2") then return "new_last_name"
 		when ("3") then return "new_cohort"
 		when ("4") then return "new_year"
  		else
  			incorrect_input_prompt
 			select_type_of_data_to_edit
 	end
end


def delete_student

	print "\nCurrent list of students:\n\n"
	print_all_students
	student_number = (select_student_for_deleting - 1)
	print_student_details_before_deleting (student_number)
	user_verification = get_delete_verification

	if (user_verification)
		remove_student_from_list(student_number)
		print "\nStudent deleted from list\n\n"
	else
		print "\nStudent deletion cancelled.\n\n"
	end
end


def select_student_for_deleting

	print "\nPlease enter student number for deletion:\n" 
	print "(click 'enter' to re-print student list)\n"

	student_count = student_list.length

	user_selection = gets.chomp

	if ((1..student_count) === user_selection.to_i)
		return user_selection.to_i
	elsif (user_selection == "")
		print "\nCurrent list of students:\n\n"
		print_all_students
		select_student_for_deleting
	else
		incorrect_input_prompt
		select_student_for_deleting
	end
end


def print_student_details_before_deleting(student_number)

	print "\nStudent entey to be deleted from list: "
	print "#{student_list[student_number][:first_name]} "
	print "#{student_list[student_number][:last_name]} "
	print "(#{student_list[student_number][:cohort]} "
	print "#{student_list[student_number][:year]})\n\n"
end


def get_delete_verification

	print "\nAre you sure you want to delete this student? (Yes/No)"
	user_input = gets.chomp
	if ((user_input == "Yes") || (user_input == "Y") || (user_input == "yes") || \
		(user_input == "y") || (user_input == "YES"))
		return true
	elsif ((user_input == "No") || (user_input == "N") || (user_input == "no") || \
		(user_input == "n") || (user_input == "NO"))
		return false
	else 
		incorrect_input_prompt
		get_delete_verification
	end
end


def remove_student_from_list(student_number)

	student_list.delete_at(student_number)

end


program_startup


