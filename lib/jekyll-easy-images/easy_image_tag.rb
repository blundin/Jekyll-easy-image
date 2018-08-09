require "mini_magick"

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
        image_resize_count = plugin_config[:srcset][:resized_images]

        # read in and process the tag markup
        render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')
        markup = /^(?:(?<preset>[^\s.:\/]+)\s+)?(?<image_src>[^\s]+\.[a-zA-Z0-9]{3,4})\s*(?<html_attr>[\s\S]+)?$/.match(render_markup)

        image_path_input = markup[:image_src]
        image_path = File.expand_path(image_path_input, __dir__)
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

        # build the attribute string from input
        html_attr_string = html_attr.inject('') { |string, attrs|
          if attrs[1]
            string << "#{attrs[0]}=\"#{attrs[1]}\" "
          else
            string << "#{attrs[0]} "
          end
        }

        # Add srcset attribute if resizing is enabled
        if image_resize_count.to_i > 1
          image = MiniMagick::Image.open(image_path)

          i = 1
          image_sizes = Array.new
          while i <= image_resize_count.to_i do
            image_sizes << image.width / i
            i += 1
          end
        end

        if image_sizes != nil
          path = build_relative_filepath(image_path_input)
          filename = File.basename(image_path, ".*")
          file_ext = File.extname(image_path)

          srcset_string = ""
          image_sizes.each do |image_size|
            puts "#{path}#{filename}-#{image_size}#{file_ext}"
          end
          html_attr_string << " #{srcset_string}"
        end

        # Return the complete image tag string
        "<img src=\"#{image_path}\" #{html_attr_string} />"
      end

      def build_relative_filepath(path_in)
        elements = path_in.split('/')
        path_out = ""
        i = 0
        until i == elements.length
          path_out << "#{elements[i]}/"
          i += 1
        end

        path_out
      end
    end
  end
end

Liquid::Template.register_tag("easy_image", Jekyll::EasyImages::EasyImageTag)
