class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #random fake email
  def self.random
    self.order(Arel.sql('RANDOM()')).first
  end
end
