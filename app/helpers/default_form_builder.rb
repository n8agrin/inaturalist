class DefaultFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  helpers = field_helpers +
            %w{date_select datetime_select time_select} +
            %w{collection_select select country_select time_zone_select} -
            %w{hidden_field label fields_for} # Don't decorate these

  helpers.each do |name|
    define_method(name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}
      label_tag = label(field, options[:label], :class => options[:label_class])
      if options[:required]
        label_tag += " " + content_tag(:span, "*", :class => 'required')
      end
      label_wrapper = content_tag(:div, label_tag, :class => 'label')
      @template.content_tag(:div, "#{label_wrapper}\n#{super}", :class => 'field')
    end
  end
end