module Jekyll
  module EasyImages
    class EasyImageTag < Liquid::Tag
      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
      end

      def render(context)
        # set plugin options
        plugin_config = context.registers[:site].config["easy_images"]
        responsive_image_class =  plugin_config[:responsive_image_class]

        # read in and process the tag markup
        render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')
        markup = /^(?:(?<preset>[^\s.:\/]+)\s+)?(?<image_src>[^\s]+\.[a-zA-Z0-9]{3,4})\s*(?<html_attr>[\s\S]+)?$/.match(render_markup)

        image_path = markup[:image_src]
        html_attr = if markup[:html_attr]
          Hash[ *markup[:html_attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten ]
        else
          {}
        end

        # iterate through all attributes, and identify the 'class' attribute
        if responsive_image_class != nil
          responsive_class_set = false
          html_attr.each do |key, value|
            if key == "class" &&
              html_attr[key] = "#{value} #{responsive_image_class}"
              responsive_class_set = true
            end
          end

          if responsive_class_set != true
            html_attr.merge!(class: responsive_image_class)
          end
        end

        # build the final attribute string
        html_attr_string = html_attr.inject('') { |string, attrs|
          if attrs[1]
            string << "#{attrs[0]}=\"#{attrs[1]}\" "
          else
            string << "#{attrs[0]} "
          end
        }

        # Return the complete image tag string
        "<img src=\"#{image_path}\" #{html_attr_string} />"
      end
    end
  end
end

Liquid::Template.register_tag("easy_image", Jekyll::EasyImages::EasyImageTag)
