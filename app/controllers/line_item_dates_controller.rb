class LineItemDatesController < ApplicationController
  before_action :set_quote

  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def create
    @line_item_date = @quote.line_item_dates.build(line_item_dates_params)

    if @line_item_date.save
      redirect_to @quote, notice: "Date created"
    else
      render :new, status: :unprocessable_content
    end
  end

  private
    def set_quote
      @quote = current_company.quotes.find(params[:quote_id])
    end

    def line_item_dates_params
      params.require(:line_item_date).permit(:date)
    end
end
