# frozen_string_literal: true

module UserDecorator
  def avatar_img
    return 'seal_icon.png' if public_twitter == false
    avatar
  end

  def avatar_img_profile
    return 'seal_icon.png' if public_twitter == false
    avatar_400
  end

  private

  def avatar_400
    avatar.sub(/normal.jpg/, '400x400.jpg')
  end
end
