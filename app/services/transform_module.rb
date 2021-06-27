# frozen_string_literal: true

# transform module name
class ISSModule
  def self.transform(iss_m)
    case iss_m
    when 'Information%20Systems%20(IS)'
      'Information Systems (IS)'
    when 'Service%20Marketing%20and%20Management'
      'Service Marketing and Management'
    when 'Service%20Innovation%20and%20Design'
      'Service Innovation and Design'
    when 'Business%20Analytics'
      'Business Analytics'
    end
  end
end
