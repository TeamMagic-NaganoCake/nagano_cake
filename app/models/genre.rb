class Genre < ApplicationRecord
  has_many :items

  validates :genre_name, presence: true, uniqueness: true

  def self.search_for(content)
    genres = Genre.where("genre_name LIKE?", "#{content}")
    genres.inject(init = []){|result, genre| result + genre.items}
  end

end
