class LineItem < ApplicationRecord
  belongs_to :line_item_date

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 2**31-1 }
  validates :unit_price, presence: true, numericality: { greater_than: 0, less_than: 2**31-1 }

  def total_price
    quantity * unit_price
  end
end
