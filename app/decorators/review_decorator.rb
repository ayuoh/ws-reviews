# frozen_string_literal: true

module ReviewDecorator
  def implementation_tarm
    "#{implementation_start_date.strftime('%Y/%m/%d')}〜#{implementation_last_date.strftime('%Y/%m/%d')}"
  end
end
