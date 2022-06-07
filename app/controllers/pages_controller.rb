class PagesController < ApplicationController
  def home
    # render html: "Hello Rails!"
    redirect_to articles_path if logged_in?
  end

  def about

  end
end
