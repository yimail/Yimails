Rails.configuration.after_initialize do
  ActionText::RichText.class_eval do
    acts_as_paranoid without_default_scope: true
  end

  ActionText::ContentHelper.allowed_attributes.add 'style'
  ActionText::ContentHelper.allowed_tags += ['table', 'tr', 'td']
  # Rails::Html::WhiteListSanitizer.allowed_tags << "iframe"
end