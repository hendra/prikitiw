require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  # ---------------------------------------
  # The following code has been generated by role_requirement.
  # You may wish to modify it to suit your need
  has_and_belongs_to_many :roles
  
  # has_role? simply needs to return true or false whether a user has a role or not.  
  # It may be a good idea to have "admin" roles return true always
  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end
  # ---------------------------------------

  validates_presence_of     :username
  validates_length_of       :username,    :within => 3..40
  validates_uniqueness_of   :username
  validates_format_of       :username,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of     :first_name
  validates_format_of       :first_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :first_name,     :maximum => 100

  validates_presence_of     :last_name
  validates_format_of       :last_name,      :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :last_name,      :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :activation_code, :activated_at

  has_friendly_id :username, :use_slug => true

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #

  after_create :make_activation_code

  def self.authenticate(username, password)
    return nil if username.blank? || password.blank?
    u = find(:first, :conditions => { :username => username, :status => true }) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def username=(value)
    write_attribute :username, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def to_param
    cached_slug
  end

  def is_admin?
    has_role?("admin")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def recently_activated?
    @activated
  end

  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    self.status = true

    UserMailer.deliver_activation(self) if save(false)
  end

  def create_reset_password_code
    reset_password_code = "#{self.id}#{ActiveSupport::SecureRandom.hex(10)}"
    UserMailer.deliver_forgot_password(self) if self.update_attribute(:reset_password_code, reset_password_code)
  end

  protected

  def make_activation_code
    self.activation_code = self.class.make_token
  end

end
