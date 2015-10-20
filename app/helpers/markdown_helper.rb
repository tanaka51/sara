module MarkdownHelper
  class SaraRenderer < Redcarpet::Render::HTML
    include Rails.application.routes.url_helpers

    def initialize(wiki, options = {})
      @wiki = wiki
      super(options)
    end

    # syntax highlight by pygments
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ['code', language, sha].join('-') do
        Pygments.highlight(code, lexer:language)
      end
    end

    def postprocess(full_document)
      regex = /\[\[(.*?)(\|(.*))?\]\]/
      full_document.gsub(regex) {
        target_name = $1
        target_blob = $3

        link, html_class =
          begin
            if target_blob.nil?
              # [[aaa]] の形
              page = @wiki.pages.find_by(name: target_name)
              if page
                [wiki_page_path(@wiki, page), '']
              else
                # TODO pass the name
                [new_wiki_page_path(@wiki, name: target_name), 'new-page']
              end
            else
              # [[aaa|bbb]] の形
              page = @wiki.pages.find_by(blob: Page.urlnize(target_blob))
              if page
                [wiki_page_path(@wiki, page), '']
              else
                # TODO pass the name and the blob
                [new_wiki_page_path(@wiki, name: target_name, blob: target_blob), 'new-page']
              end
            end
          end

        ApplicationController.helpers.link_to($1, link, class: html_class)
      }
    end
  end

  def markdown(wiki, text)
    renderer = SaraRenderer.new(wiki, hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

