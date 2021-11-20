puts "Creating User"
u = User.create(
  name: 'tester',
  email: 'tester@test.com',
  password: 'password'
)
puts "User #{u.email} created"

puts 'Creating room'
room = Room.create(name: Room::MAIN_ROOM_NAME)
puts "Room #{room.name} created"

Message.create(user: u, room: room, content: 'hello from seed file')
