class User < ActiveRecord::Base
  has_secure_password

  def fullname
    "#{firstname} #{lastname}".titleize
  end

  def get_scores
    q_params = {lastname: self.lastname, firstname: self.firstname, dob:self.dob}
    q_params = q_params.delete_if {|k,v| v.to_s.empty?}
    resp = HTTParty.get('http://www.voterfile.nyc/score', query: q_params)
    JSON.parse(resp, symbolize_names: true)
  end
end
