class Welcome2Controller < ApplicationController
  def index
    render file: "app/views/welcome2/index", :formats => [:html]
  end
end
