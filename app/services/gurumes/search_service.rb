module Gurumes
  class SearchService
    def initialize(area, food)
      @area = area
      @food = food
      @hit = 21
    end

    def run
      uri = URI.parse URI.encode("https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{Rails.application.credentials.gnavi[:access_key_id]}&address=#{@area}&freeword=#{@food}&&hit_per_page=#{@hit}")
      response = JSON.load(Net::HTTP.get(uri))
      response["rest"]
    end
  end
end
