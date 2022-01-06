Rails.configuration.after_initialize do
  ActionText::RichText.class_eval do
    acts_as_paranoid without_default_scope: true
  end
end