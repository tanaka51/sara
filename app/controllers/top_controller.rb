class TopController < ApplicationController
  def index
    # TODO authorization with current user
    @wikis = Wiki.all
  end
end
