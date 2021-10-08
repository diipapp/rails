module ApplicationHelper
  def show_svg(icon_name, options={})
    file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', "#{icon_name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each {|attr, value| svg[attr.to_s] = value}

    doc.to_html.html_safe
  end  

  def get_user_name
    if user_signed_in?
      current_user.profile.username  
    else
      params[:username]
    end
  end
end
