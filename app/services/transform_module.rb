# frozen_string_literal: true

class ISSModule
  def self.transform(iss_m)
    if iss_m=="Information%20Systems%20(IS)"
      "Information Systems (IS)"
    elsif iss_m=="Service%20Marketing%20and%20Management"
      "Service Marketing and Management"
    elsif iss_m=="Service%20Innovation%20and%20Design"
      "Service Innovation and Design"
    elsif iss_m=="Business%20Analytics"
      "Business Analytics"
    end
  end
end
