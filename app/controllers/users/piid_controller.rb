class Users::PiidController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:capture]
  # skip_before_action :authenticate_user!, :verify_user_have_username

  def capture
    og_title, og_image = extract(params[:link])

    tip_id = params[:tip_id]
    if tip_id.present?
      recommendation = current_user.recomendations.where(id: tip_id).last
      return not_found_crude unless recommendation.present?

      recommendation.update(title: og_title, image: og_image, url: params[:link])
    else
      category = Category.find_by_id(params[:category_id])
      return not_found_crude unless category.present?

      current_user.recomendations.new(category_id: category.id,
                                      title: og_title, 
                                      image: og_image, 
                                      url: params[:link]).save!
    end

    render json: {og_title: og_title, og_image: og_image}, status: 200
  end

  private

    def extract(link)
      link = params[:link]
  
      case link
      when /spotify.com/
        page = MetaInspector.new(resolve_url(link))
        og_title = page.title
        og_image = page.images.best  
      when /netflix.com/
        get_id_movie = link.scan(/\d+/).first
        new_url_netflix = "https://www.netflix.com/br-en/title/#{get_id_movie}"
  
        conteudo=%x( wget -qO- #{new_url_netflix} )
        page = Nokogiri::HTML(conteudo);
        og_title = page.at('meta[property="og:title"]')['content']
        og_image = page.at('meta[property="og:image"]')['content']
      else
        url_base = CGI.escape(link)
        url = URI("https://opengraph.io/api/1.1/site/#{url_base}?accept_lang=auto&use_proxy=true&app_id=100c86c1-fac2-4770-9fee-238d8d0d11a1")
        response = JSON.parse(Net::HTTP.get(url))
  
        og_title = response['hybridGraph']['title']
        og_image = response['hybridGraph']['image']  
      end
    
      [og_title, og_image]
    end

    # THANK YOU MAN <3
    # https://gist.github.com/sekrett/7dd4177d6c87cf8265cd
    def resolve_url(uri_str, agent = 'curl/7.43.0', max_attempts = 10, timeout = 10)
      attempts = 0
      cookie = nil
  
      until attempts >= max_attempts
        attempts += 1
  
        url = URI.parse(uri_str)
        http = Net::HTTP.new(url.host, url.port)
        http.open_timeout = timeout
        http.read_timeout = timeout
        path = url.path
        path = '/' if path == ''
        path += '?' + url.query unless url.query.nil?
  
        params = { 'User-Agent' => agent, 'Accept' => '*/*' }
        params['Cookie'] = cookie unless cookie.nil?
        request = Net::HTTP::Get.new(path, params)
  
        if url.instance_of?(URI::HTTPS)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response = http.request(request)
  
        case response
          when Net::HTTPSuccess then
            break
          when Net::HTTPRedirection then
            location = response['Location']
            cookie = response['Set-Cookie']
            new_uri = URI.parse(location)
            uri_str = if new_uri.relative?
                        url + location
                      else
                        new_uri.to_s
                      end
          else
            raise 'Unexpected response: ' + response.inspect
        end
  
      end
      raise 'Too many http redirects' if attempts == max_attempts
  
      uri_str
    end   

end