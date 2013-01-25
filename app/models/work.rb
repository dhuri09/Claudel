class Work < ActiveRecord::Base
  
  #Associations
  has_many :images
  belongs_to :type
  belongs_to :domain
  belongs_to :time_period
  
  attr_accessible :name, :description, :time_period_id, :type_id, :domain_id, :thumbnail
  
  #Validations
  validates_presence_of :name, :time_period_id, :type_id, :domain_id
  
  #Images
  has_attached_file :thumbnail, 
    :styles => { :small => "150x150" },
    :storage => :s3,
        :s3_credentials => {
          :access_key_id => 'AKIAIGVNEJUWP6KDGC6A',
          :secret_access_key => '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',
          :bucket => "Claudel"
        }
  
  def as_json
  {
    "id" => read_attribute(:id),
    "name" => read_attribute(:name),
    "description" => read_attribute(:description),
    "type" => type,
    "domain" => domain,
    "time_period" => time_period
  }
  end

end
