class Beer < ApplicationRecord
  belongs_to :brewery

  def self.list_by_nitro_true
    self.where(nitro: true)
  end

  def self.order_by_alphabetical_style
    self.order(style: :asc)
  end

  def self.list_above_abv(abv)
    self.where("abv > ?", abv)
  end
  
  def self.exact_match(style)
    self.where(style: style)
  end
end