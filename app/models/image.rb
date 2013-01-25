class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :image, 
    :styles => { :large => "500x" },
    :storage => :s3,
        :s3_credentials => {
          :access_key_id => 'AKIAIGVNEJUWP6KDGC6A',
          :secret_access_key => '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',
          :bucket => "Claudel"
        }
end
