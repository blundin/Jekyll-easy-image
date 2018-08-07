module Jekyll
  module EasyImages
    class EasyImageTag < Liquid::Tag
      def initialize(tag_name, image_path, tokens)
        super
        @path = image_path
      end

      def render(context)
        "<img class=\"img-fluid\" src=\"#{@path}\" />"
      end
    end
  end
end


Liquid::Template.register_tag("easy_image", Jekyll::EasyImages::EasyImageTag)
