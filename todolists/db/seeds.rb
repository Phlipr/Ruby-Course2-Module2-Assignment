# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Destroy all current data in databases
User.destroy_all
TodoList.destroy_all
TodoItem.destroy_all
Profile.destroy_all

# Setup Users

User.create! [
  { username: "Fiorina", password_digest: "RunningForSenate" },
  { username: "Trump", password_digest: "MAGAt" },
  { username: "Carson", password_digest: "IWishIWerePresident" },
  { username: "Clinton", password_digest: "IAmSupposedToBePresident" }
]


# Setup Profiles

carly = User.find_by username: "Fiorina"

carly.create_profile gender: "female", birth_year: 1954, first_name: "Carly", last_name: "Fiorina"

donald = User.find_by username: "Trump"

donald.create_profile gender: "male", birth_year: 1946, first_name: "Donald", last_name: "Trump"

ben = User.find_by username: "Carson"

ben.create_profile gender: "male", birth_year: 1951, first_name: "Ben", last_name: "Carson"

hillary = User.find_by username: "Clinton"

hillary.create_profile gender: "female", birth_year: 1947, first_name: "Hillary", last_name: "Clinton"


# Setup todo_lists

User.all.each {
  |user| user.todo_lists.create! [ { list_name: "To Do List for #{user.profile.first_name}:", list_due_date: (Date.today + 1.year) } ]
}

# Setup todo_items

TodoList.all.each {
  |list|
    person = User.find(list.user_id)
    name = person.profile.first_name
    for i in 0..4 do
      list.todo_items.create! due_date: (Date.today + 1.year), title: "Item #{ ( i + 1 ) } for #{name}", description: "This is item #{ ( i + 1 ) } on the todo list for #{name}.", completed: false
    end
}
