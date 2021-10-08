require 'airbrake-ruby'

if Rails.env.production?
  Airbrake.configure do |c|
    c.project_id = 365733
    c.project_key = 'bd56814f4b50e1d23d3928a6c7df190f'
  end
end
