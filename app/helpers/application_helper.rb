module ApplicationHelper
  def default_meta_tags
    {
      site: '演劇のWSの感想をシェアするサービス',
      title: 'WS Reviews',
      reverse: true,
      charset: 'UTF-8',
      description: '演劇のWSの感想をシェアしましょう！',
      keywords: '演劇、ワークショップ、レビュー',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp.png')
      }
    }
  end
end
