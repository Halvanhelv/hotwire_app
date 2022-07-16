# frozen_string_literal: true

module ApplicationHelper
  def inline_errors_for(object, field, style: 'form__error')
    if object.errors[field.to_sym].any?
      raw %(
        <p class="#{style}">
          #{object.errors[field.to_sym].first}
        </p>
      )
    end
  end
end
