Plant.destroy_all
User.destroy_all
UserPlant.destroy_all

plants = Plant.create ([
  {name: 'Aloe Vera', description: 'The Aloe Vera plant (succulent type) is well known for offering possible health and beauty benefits. This succulent is a tough species that is very easy to care for and rarely presents problems for most growers.'},
  {name: 'Snake plant', description: 'This carefree, tough succulent grows almost anywhere. Snake plant (Sansevieria spp.) tolerates neglect but responds nicely to good care. '},
  {name: 'Peace lily', description: 'The easy-care peace lily (Spathiphyllum wallisii) tolerates low humidity and low light. Its glossy, lance-shape leaves tip arching stems that surround the central flower spikes.'},
  {name: 'English ivy', description: 'This versatile foliage plant’s dainty demeanor makes it suitable for hanging baskets or pots. It’s among the best houseplants for training on topiary forms or using as a groundcover beneath larger houseplants.'}
])

user = User.create(
   email: 'whatever@hotmail.com',
   password: 'whatever',
   password_confirmation: 'whatever'
)

plants.each do |plant|
  UserPlant.create(user_id: user.id, plant_id: plant.id)
end
