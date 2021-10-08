class UserProfile < ApplicationRecord
  
  # ----------------------------------------------------------------------------  
  # Associations
  # ----------------------------------------------------------------------------
  belongs_to :user

  # ----------------------------------------------------------------------------  
  # Validates
  # ----------------------------------------------------------------------------
  validates :name, :username, presence: true

  validates :username, uniqueness: true
  validates :username, length: { maximum: 30 }
  validates :username, format: { with: /\A[a-zA-Z0-9\._-]+\z/, message: "username must contains only letters, numbers, periods and underscores." }

  def username=(new_username)
    self[:username] = new_username.unaccent.downcase if new_username.present?
  end

  def social_links
    links = {}
    links[:spotify]   = spotify if spotify.present?
    links[:youtube]   = youtube if youtube.present?
    links[:twitter]   = twitter if twitter.present?
    links[:twitch]    = twitch if twitch.present?
    links[:tiktok]    = tiktok if tiktok.present?
    links[:instagram] = instagram if instagram.present?
    links[:pinterest] = pinterest if pinterest.present?
    links[:site]      = site if site.present?
    links[:facebook]  = facebook if facebook.present?
    links[:medium]    = medium if medium.present?
    links[:behance]   = behance if behance.present?
    links[:linkedin]  = linkedin if linkedin.present?
    links[:whatsapp]  = whatsapp if whatsapp.present?
    links[:email]     = email if email.present?
    
    links
  end

end