# frozen_string_literal: true

module ReviewDecorator
  def implementation_tarm
    "#{implementation_start_date.strftime('%Y/%m/%d')}〜#{implementation_last_date.strftime('%Y/%m/%d')}"
  end

  def format_created_at
    "#{created_at.strftime('%Y/%m/%d')} 投稿"
  end

  def format_fee
    return if fee.blank?

    "#{number_to_currency(fee, unit: '')}#{t('currency.unit')}"
  end
end
