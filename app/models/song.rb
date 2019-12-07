class Song < ActiveRecord::Base
  #title must not be blank
  #cannot be repeated by the same artist in the same year 
  
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'cannot be repeated by the same artist in the same year'
  }
  
  #released, a boolean describing whether the song was ever officially released.
  #must be true or false
  
  validates :released, inclusion: { in: [true, false] }
  

  #release_year, an Integer
  #optional if released is false
  #must not be blank if released is true
  #must be less less_than_or_equal_to the current year
  
  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
    
  #artist_name, a String
  #must not be blank
  
    validates :artist_name, presence: true  
  end
  
    
  def released?
    released
  end
end