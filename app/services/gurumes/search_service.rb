module Gurumes
  class SearchService
    def initialize(area, food)
      @area = area
      @food = food
      @hit = 20
    end

    def run
      api_id = "22bdbb2bc86a783507f6acff85f6606c"
      uri = URI.parse URI.encode("https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{api_id}&address=#{@area}&freeword=#{@food}&&hit_per_page=#{@hit}")
      response = JSON.load(Net::HTTP.get(uri))
      response["rest"]
    end
  end
end
