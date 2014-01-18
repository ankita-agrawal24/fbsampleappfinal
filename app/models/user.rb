class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :relationships,  foreign_key: "follower_id",  dependent: :destroy
  has_many  :followed_users, through:     :relationships, source:    :followed

  has_many  :reverse_relationships,  foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many  :followers, through:     :reverse_relationships, source:    :follower
  
  has_many  :albums, dependent: :destroy

  validates :name,           presence: true
  validates :location,       presence: true
  has_attached_file :photo
  

  def self.from_omniauth(auth)
  	where(auth.slice(:provider, :fid)).first_or_initialize.tap do |user|
  		user.provider = auth.provider
  		user.fid = auth.uid
  		user.name = auth.info.name
      user.email = auth.info.email
      user.password = "password"
      user.location = auth.info.location
  		user.oauth_token = auth.credentials.token
  		user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  		user.save(:validates => false)
  	end
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def self.search(search)
    #search = "" unless search.present? 
    if search.present?
      # paginate :per_page => 12, :page => page, :conditions => ['name LIKE ?', "%#{search}%"]
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      #where('name LIKE ?', "%#{search}%")
  
    else
       #paginate :per_page => 12, :page => page, :conditions => ['name LIKE ?', "%#{search}%"]
      find(:all)
    end
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end
end