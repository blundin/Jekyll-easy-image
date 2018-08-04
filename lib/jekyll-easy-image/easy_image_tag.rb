module Jekyll
  class EasyImageTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "#{@ouput}"
    end
  end
end

Liquid::Template.register_tag('responsive_image', Jekyll::EasyImageTag)
