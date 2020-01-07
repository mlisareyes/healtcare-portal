class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :patients

  #def patients
    # I'm a user, I want to see which patients are mine
    # Iterate through all patients
    # What attributes does a patient have: name, gender, birthday, user_id
    # Return all patients where the user_id attribute matches the id of the user

    #Patient.all.select {|patient| patient.user_id = self.id}
    #This function now is just going to run a sql query to get all of the rows from the patients column that belong to this user
    #Iterators review: map returns an array with the same amount of elements as the original collection.
    #We use map when we want to make a transformation on every object in the collection

    #map, select, find

  #end

end

#chris = User.new
#patient1.user == chris

#chris.patients
