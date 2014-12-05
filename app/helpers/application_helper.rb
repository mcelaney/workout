# Application Helper
module ApplicationHelper
  def display_any_errors_for(model:, text:)
    return _render_errors(model, text) if model.errors.any?
    ''
  end

  private

  def _render_errors(model, text)
    content_tag(:h2, "#{pluralize(model.errors.count, 'error')} #{text}")
    content_tag :ul do
      model.errors.full_messages.map do |message|
        concat(content_tag(:li, message))
      end
    end
  end
end
