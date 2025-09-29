class LineItemDatesController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date, only: [ :edit, :update, :destroy ]
  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def create
    @line_item_date = @quote.line_item_dates.build(line_item_dates_params)

    if @line_item_date.save
      respond_to do |format|
        format.html { redirect_to @quote, notice: "Date created" }
        format.turbo_stream { flash.now[:notice] = "Date created" }
      end
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @line_item_date.update(line_item_dates_params)
      respond_to do |format|
        format.html { redirect_to @quote, notice: "Date updated" }
        format.turbo_stream { flash.now[:notice] = "Date updated" }
      end
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @line_item_date
      @line_item_date.destroy()
      respond_to do |format|
        format.html { redirect_to @quote }
        format.turbo_stream { flash.now[:notice] = "Date deleted" }
      end
    end
  end

  private
    def set_line_item_date
      @line_item_date = @quote.line_item_dates.find(params[:id])
    end

    def set_quote
      @quote = current_company.quotes.find(params[:quote_id])
    end

    def line_item_dates_params
      params.require(:line_item_date).permit(:date)
    end
end
