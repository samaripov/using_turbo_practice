class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  def index
    @quotes = Quote.ordered
  end

  def show
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote created" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @quote
      @quote.destroy
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote deleted" }
        format.turbo_stream
      end
    end
  end

  private
    def set_quote
      begin
        @quote = Quote.find(params[:id])
      rescue
        @quote = nil
      end
    end

    def quote_params
      params.require(:quote).permit(:name)
    end
end
