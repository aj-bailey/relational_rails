class Brewery < ApplicationRecord
  has_many :beers

  def self.order_by_most_recently_created
    self.order(created_at: :desc)
  end
end