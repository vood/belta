class Feed < ActiveRecord::Base
  DELIMITER = ','
  def selector_blacklist_array
    selector_blacklist.split(self::DELIMITER).select{|item| item.trim }
  end
end
