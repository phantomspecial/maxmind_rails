class MaxmindsController < ApplicationController
  def index
    @search_form = MaxmindSearchForm.new
  end

  def search
    @search_form = MaxmindSearchForm.new(search_params)

    return render :index unless @search_form.valid?

    @results = @search_form.search

    respond_to do |format|
      format.html
      format.csv { send_data render_to_string, filename: @search_form.filename, type: :csv }
    end
  end

  private

  def search_params
    params.require(:q).permit(:ip_addresses)
  end
end
