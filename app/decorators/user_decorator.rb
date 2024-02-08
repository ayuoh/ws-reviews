# frozen_string_literal: true

module UserDecorator
  def avatar_400
    avatar.sub(/normal.jpg/, '400x400.jpg')
  end
end
