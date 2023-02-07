class Brewery < ApplicationRecord
  has_many :beers

  def self.order_by_most_recently_created
    self.order(created_at: :desc)
  end

  def num_beers
    beers.count
  end

  def self.order_by_num_beers_descending
    self.joins(:beers).group(:id).order('COUNT(beers.id) DESC')
  end

  def self.exact_match(name)
    self.where(name: name)
  end
end