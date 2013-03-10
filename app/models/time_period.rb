class TimePeriod < ActiveRecord::Base
  attr_accessible :name
  
  #Lets you sort by season in chronological order
  def season
    season = self.name.split[0]
    if season == "Fall"
      return self.name.split[1] + "3"
    elsif season == "Summer"
      return self.name.split[1] + "2"
    elsif season == "Spring"
      return self.name.split[1] + "1"
    else
      return self.name.split[1] + "0"
    end
  end
  
end
