module SimpleForm
  module Inputs
    class DatePickerInput < Base
      def input(wrapper_options = nil)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        @builder.datetime_field(attribute_name, merged_input_options)
      end

      private

      def input_html_options
        if options.key?(:input_html) && options[:input_html].key?(:value)
          value = options[:input_html][:value]
        elsif options.key? :value
          value = options[:value]
        elsif object.respond_to?(attribute_name)
          value = object.send(attribute_name)
        else
          value = ''
        end

        value = Time.zone.parse(value) if value.is_a?(String)
        value = value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)

        result = { class: 'form-control text-center date datepicker', value: value.presence || '' }
        if options.key? :input_html
          result[:class] += ' ' + options[:input_html][:class] if options[:input_html][:class].present?
          result.merge(options[:input_html].except(:class, :value))
        else
          result
        end
      end
    end
  end
end
