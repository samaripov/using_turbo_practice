class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @lines_item_dates = @quote.line_item_dates.includes(:line_items).ordered
    @quote_total = @quote.line_item_dates.includes(:line_items).reduce(0) { |sum, line_item_date| sum + line_item_date.line_items.sum(:unit_price) }
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_company.quotes.build(quote_params)
    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote created" }
        format.turbo_stream { flash.now[:notice] = "Quote created" }
      end
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote updated" }
        format.turbo_stream { flash.now[:notice] = "Quote updated" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @quote
      @quote.destroy
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote deleted" }
        format.turbo_stream { flash.now[:notice] = "Quote deleted" }
      end
    end
  end

  private
    def set_quote
      begin
        @quote = current_company.quotes.find(params[:id])
      rescue
        @quote = nil
      end
    end

    def quote_params
      params.require(:quote).permit(:name)
    end
end
