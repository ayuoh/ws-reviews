# frozen_string_literal: true

module ReviewDecorator
  def implementation_tarm
    "#{implementation_start_date.strftime('%Y/%m/%d')} 〜 #{implementation_last_date.strftime('%Y/%m/%d')}"
  end

  def format_created_at
    "#{created_at.strftime('%Y/%m/%d')} 投稿"
  end

  def format_prefecture
    prefecture.present? ? prefecture : '-'
  end

  def format_fee
    return '-' if fee.blank?

    "#{number_to_currency(fee, unit: '')}#{t('currency.unit')}"
  end

  def evaluate_satisfaction
    return '高い！' if satisfaction >= 80
    return 'やや高い' if satisfaction >= 60
    return '普通' if satisfaction >= 40
    return 'やや低い' if satisfaction >= 20

    '低い…'
  end
end
