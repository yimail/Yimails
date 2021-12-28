class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #random fake email
  def self.random
    self.order(Arel.sql('RANDOM()')).first
  end

  def after_authy_enabled_path_for(resource)
    letters_path(current_user)
  end

  def after_authy_verified_path_for(resource)
    letters_path(current_user)
  end

end
