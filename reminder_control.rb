require 'sqlite3'
load  'reminder.rb'


def get_choice 
    puts "1--Add"
    puts "2--Delete"
    puts "3--Modify"
    puts "4--View all"
    puts "0--Quit"
    puts "Please input your choice:"
    STDOUT.flush

    _choice = gets.chomp
    return _choice
end

def add_item
    puts "event?"
    _event = gets.chomp
    puts "due date?"
    _due_date = gets.chomp
    puts "status?"
    _status = gets.chomp
   
    Reminder.new(:event =>_event, :due_date =>_due_date, :status => _status).save
    puts "Successfully added"
    STDOUT.flush
end

def delete_item
    puts "please enter the event id:"
    _id= gets.chomp
    if Reminder.find(_id)
        Reminder.find(_id).destroy
    else
        puts "No such record"
    end
end

def alter_item
    puts "Please enter the event id"
    _id = gets.chomp
    record = Reminder.find(_id)
    puts record.inspect 

    puts "Re-enter event:"
    _event = gets.chomp
    puts "Re-enter due date?"
    _due_date = gets.chomp
    puts "Re_enter status?"
    _status = gets.chomp

    Reminder.update(_id,:event=>_event,:due_date =>_due_date, :status=>_status)
end

def view_all
    if Reminder.count == 0
        puts "---No Reminders!"
    else
        puts "---All Records:"
        Reminder.all.each do |reminder|
            puts reminder.inspect
        end
    end
end

def my_loop(_choice)
    while _choice != "0" do
        case _choice
        when "1"
            add_item
        when "2"
            delete_item
        when "3"
            alter_item
        when "4"
            view_all
        else
            puts "No such choice"
        end
        _choice = get_choice
    end
    puts "Goodbye!"
end

def my_main_control
    puts "Welcome!"
    my_loop(get_choice)
end

if __FILE__==$0
    my_main_control
end
