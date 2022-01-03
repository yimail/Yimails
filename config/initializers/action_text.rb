Rails.configuration.after_initialize do
  ActionText::RichText.class_eval do
    acts_as_paranoid
  end
end