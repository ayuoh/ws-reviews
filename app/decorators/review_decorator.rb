# frozen_string_literal: true

module ReviewDecorator
  def implementation_tarm
    "#{implementation_start_date.strftime('%Y/%m/%d')}〜#{implementation_last_date.strftime('%Y/%m/%d')}"
  end

  def recruitment_tarm
    return if recruitment_start_date.blank?

    "#{recruitment_start_date.strftime('%Y/%m/%d')}〜#{recruitment_last_date.strftime('%Y/%m/%d')}"
  end

  def format_fee
    return if fee.blank?

    "#{number_to_currency(fee, unit: '')}#{t('currency.unit')}"
  end
end
