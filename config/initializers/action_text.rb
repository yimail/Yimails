Rails.configuration.after_initialize do
  ActionText::RichText.class_eval do
    acts_as_paranoid without_default_scope: true
  end

  ActionText::ContentHelper.allowed_attributes += %w[style href src alt colspan width height rowspan align valign abbr border cellpadding cellspacing frame rules char bgcolor charoff class target]

  ActionText::ContentHelper.allowed_tags += %w[table tbody span tr td center a img]
end