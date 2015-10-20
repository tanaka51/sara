class SidebarsController < ApplicationController
  layout 'page'

  before_action :set_wiki
  before_action :set_sidebar

  def edit
  end

  def update
    if @sidebar.update(page_params)
      redirect_to wiki_page_path(@wiki, @wiki.pages.welcome), notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find_by(blob: params[:wiki_id])
  end

  def set_sidebar
    @sidebar = @wiki.sidebar
  end

  def page_params
    params.require(:sidebar).permit(:content).merge(wiki: @wiki)
  end
end
