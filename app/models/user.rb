class User < ApplicationRecord
  before_destroy :cannot_destroy_only_one_admin
  before_update :cannot_update_only_one_admin
  has_many :tasks, dependent: :destroy

  has_secure_password

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email,uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


  private

  def cannot_destroy_only_one_admin
    @admin_user = User.where(admin: true)
    if @admin_user.count == 1 && self.admin
      errors.add :base, '少なくとも1人、ログイン用の認証が必要です'
      # return falseではなく throw :abort
      throw :abort
    end
  end

  def cannot_update_only_one_admin
    @admin_user = User.where(admin: true)
    if @admin_user.count == 1 && self.admin
      errors.add :base, '少なくとも1人、ログイン用の認証が必要です'
      # return falseではなく throw :abort
      throw :abort
    end
  end
end