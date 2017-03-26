module Rhtml
  class Document

    attr_accessor :content
    alias :out :content

    TAGS = [:a, :abbr, :address, :article, :aside, :audio, :b, :base, :bdi, :blockquote, :body, :button, :canvas, :caption,
            :cite, :code, :col, :colgroup, :data, :datalist, :dd, :del, :details, :dfn, :dialog, :div, :dl, :dt, :em, :embed,
            :fieldset, :figcaption, :figure, :footer, :form, :h1, :h2, :h3, :h4, :h5, :h6, :head, :header, :html, :i, :iframe,
            :ins, :kbd, :keygen, :label, :legend, :li, :main, :map, :mark, :menu, :menuitem, :meter, :nav, :noscript, :object,
            :ol, :optgroup, :option, :output, :p, :picture, :pre, :progress, :q, :rp, :rt, :ruby, :s, :samp, :script, :section,
            :select, :small, :span, :strong, :style, :sub, :summary, :sup, :table, :tbody, :td, :textarea, :tfoot, :th, :thead,
            :time, :title, :tr, :u, :ul, :var, :video, :wbr, :area, :bdo, :br, :hr, :img, :input, :link, :meta, :param, :source,
            :track]

    def initialize(&block)
      @content = ''
      create_tag_methods
      instance_eval &block if block
    end

    def create_tag_methods
      TAGS.each do |tag|
        eigenclass = class << self; self; end
        eigenclass.class_eval do
          define_method tag do |*args, &block|
            contents = get_content(args)
            options = build_options(get_options(args))
            content << "<#{tag}#{options}>"
            content << "#{contents}" if contents
            instance_eval &block     if block
            content << "</#{tag}>"   if contents || block
          end
        end
      end
    end

    def text(t)
      content << t
    end

    private

    # Find tag content from arguments
    def get_content(args)
      args.detect{|arg| arg.is_a? String}
    end

    # Find tag options from arguments
    def get_options(args)
      args.detect{|arg| arg.is_a? Hash} || {}
    end

    # Build html options string from Hash (key="value")
    def build_options(options)
      options.collect{ |key, value| " #{key}=\"#{value}\"" }.join('')
    end
  end
end