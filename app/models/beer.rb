class Beer < ApplicationRecord
  belongs_to :brewery

  def self.list_by_nitro_true
    self.where(nitro: true)
  end
end