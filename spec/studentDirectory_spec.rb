require "studentDirectory.rb"

describe "Student Directory" do 

	it 'knows to add a new student to the list' do

		student_A = collect_student_details("Abi","Potato","May","2014")
		expect(add_student_to_list(student_A)).to eq student_list
	end

	it 'knows NOT to add new student to list if first_name is blank' do

		student_A = collect_student_details("","Potato","May","2014")
		expect(add_student_to_list(student_A)).to eq nil
	end

	it 'how to create the student list if it doesn\'t already exist' do

		expect(student_list).to eq []
	end

	it 'knows how to add more than one student to the student list' do

		student_A = collect_student_details("Alex","Guyava","May","2014")
		student_B = collect_student_details("Kathy","Mango","June","2015")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		expect(student_list).to eq [student_A, student_B]
	end

	it 'automatically sets default cohort to current month if no value given' do
		student_A = collect_student_details("Alex","Guyava","","2014")
		add_student_to_list(student_A)
		expect(student_list.first[:cohort]).to eq (Time.now.strftime("%B")).to_sym
	end

	it 'automatically sets default year to current year if no value given' do

		student_A = collect_student_details("Alex","Guyava","May","")
		add_student_to_list(student_A)
		expect(student_list.first[:year]).to eq (Time.now.strftime("%Y")).to_i 

	end

	it 'automatically capitalizes first name if not alreay capitalized' do

		student_A = collect_student_details("alex","Guyava","May","2014")
		add_student_to_list(student_A)
		expect(student_list.first[:first_name]).to eq "Alex"
 
	end

	it 'automatically capitalizes last name if not alreay capitalized' do

		student_A = collect_student_details("alex","apple","May","2014")
		add_student_to_list(student_A)
		expect(student_list.first[:last_name]).to eq "Apple"
 
	end

	it 'sorts list alphabetically according to first name with every new entry' do

		student_A = collect_student_details("Roi","Papaya","May","2014")
		student_B = collect_student_details("alex","apple","May","2014")
		student_C = collect_student_details("Kathy", "Mango", "June", "2015")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		add_student_to_list(student_C)
		expect(student_list).to eq [student_B, student_C, student_A]
	end	

	it 'knows if student_list.csv file doesn\'t exists' do

		file_name = "test_list.csv"
		File.delete(file_name) if File.file?(file_name)
		expect(file_available?(file_name)).to be_false

	end

	it 'knows if student_list.csv file already exists' do

		file_name = "test_list.csv"
		File.new(file_name, "a")		
		expect(file_available?(file_name)).to be_true
		File.delete(file_name)


	end

	it 'knows how to save student list into csv file' do

		file_name = "test_list.csv"
		student_A = collect_student_details("Alex","Apple","May","2014")
		student_B = collect_student_details("Roi","Papaya","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		save_list_to_file (file_name)
		student_list_info = []
		file = File.open(file_name, "r")
		file.readlines.each do |line|
			first_name, last_name, cohort, year = line.chomp.split(',')
			student_list_info << {first_name: first_name, last_name: last_name, cohort: cohort.to_sym, year: year.to_i}
  		end
		file.close
		expect(student_list_info).to eq [student_A, student_B]
		File.delete(file_name)
	end

	it 'knows how to load student list from file' do

		file_name = "test_list.csv"
		student_A = collect_student_details("Alex","Apple","May","2014")
		student_B = collect_student_details("Roi","Papaya","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		save_list_to_file(file_name)
		clear_student_list
		load_list_from_file(file_name)
		expect(student_list).to eq [student_A,student_B]
		File.delete(file_name)
	end


	it "knows how to print the main menu in terminal" do

		l1 = "Please select one of the following options:"
		l2 = "1. Add new students to list"
		l3 = "2. Show list of students"
		l4 = "3. Clear list of students"
		l5 = "4. Load list of students from file"
		l6 = "5. Save list of students to file"
		l7 = "6. Edit student details"
		l8 = "7. Delete student from list"
		l9 = "9. Exit"
		output = "#{l1}\n#{l2}\n#{l3}\n#{l4}\n#{l5}\n#{l6}\n#{l7}\n#{l8}\n#{l9}\n"
		expect(STDOUT).to receive(:puts).with output
		print_main_menu
	end


	it "knows how to take input from the user" do

		expect(STDIN).to receive(:gets).and_return("")
		get_input_from_user
	end


	it "knows how to remove new line character from user input" do
		expect(STDIN).to receive(:gets).and_return("some_text\n")
		expect(get_input_from_user).to eq "some_text"
	end


	it "knows how to clear student list" do
		student_A = collect_student_details("Roi","Papaya","May","2014")
		add_student_to_list(student_A)
		expect(clear_student_list).to eq []
	end

	it "knows how to edit existing student first name" do
		student_A = collect_student_details("Mark","Papaya","May","2014")
		student_B = collect_student_details("Roi","Apple","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		edit_first_name(1, "John")
		expect(student_list[1][:first_name]).to eq "John"
	end

	it "knows how to edit existing student last name" do
		student_A = collect_student_details("Mark","Papaya","May","2014")
		student_B = collect_student_details("Roi","Apple","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		edit_last_name(1, "Papaya")
		expect(student_list[1][:last_name]).to eq "Papaya"
	end

	it "knows how to edit existing student cohort" do
		student_A = collect_student_details("Mark","Papaya","May","2014")
		student_B = collect_student_details("Roi","Apple","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		edit_cohort(1, "June")
		expect(student_list[1][:cohort]).to eq :June
	end

	it "knows how to edit existing student year" do
		student_A = collect_student_details("Mark","Papaya","May","2014")
		student_B = collect_student_details("Roi","Apple","May","2014")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		edit_year(1, "2015")
		expect(student_list[1][:year]).to eq 2015
	end


	it "knows how to remove a student from list" do

		student_A = collect_student_details("Roi","Papaya","May","2014")
		student_B = collect_student_details("alex","apple","May","2014")
		student_C = collect_student_details("Kathy", "Mango", "June", "2015")
		add_student_to_list(student_A)
		add_student_to_list(student_B)
		add_student_to_list(student_C)
		student_count = student_list.length
		remove_student_from_list(2)
		expect(student_list.length).to eq (student_count - 1)
	end

	context "knows how to process user main menu selection" do

		it "knows to input student detals when user selects 1" do
			expect(self).to receive(:input_new_student)
			user_menu_selection("1")
		end
		
		it "knows to print student list when user selects 2" do
			expect(self).to receive(:print_student_list)
			user_menu_selection("2")
		end
	
		it "knows how to clear student list when user selects 3" do
			expect(self).to receive(:clear_student_list_query)
			user_menu_selection("3")
		end

		it "knows how to load the student list from file when user selects 4" do
			expect(self).to receive(:load_student_list_query)
			user_menu_selection("4")
		end

		it "knows how to save the student list to file when user selects 5" do
			expect(self).to receive(:save_list_to_file)
			user_menu_selection("5")
		end

		it "knows how to edit existing student details when user selects 6" do
			expect(self).to receive(:edit_student_details)
			user_menu_selection("6")
		end

		it "knows how to delete existing student from list when user selects 7" do
			expect(self).to receive(:delete_student)
			user_menu_selection("7")
		end

		it "knows how to exit program when user selects 9" do
			expect(self).to receive(:exit_program)
			user_menu_selection("9")
		end

		it "knows how to ask user to select again when wrong selection is made" do
			expect(self).to receive(:incorrect_input_prompt)
			user_menu_selection("a")
		end

	end

end

