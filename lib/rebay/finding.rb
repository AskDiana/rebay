module Rebay
  class Finding < Rebay::Api
    BASE_URL = 'http://svcs.ebay.com/services/search/FindingService/v1'
    VERSION = '1.0.0'
    
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsAdvanced.html
    def find_items_advanced(params)
      raise ArgumentError unless params[:keywords] or params[:categoryId]
      get_json_response(build_request_url('findItemsAdvanced', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByCategory.html
    def find_items_by_category(params)
      raise ArgumentError unless params[:categoryId]
      get_json_response(build_request_url('findItemsByCategory', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByKeywords.html
    def find_items_by_keywords(params)
      raise ArgumentError unless params[:keywords]
      get_json_response(build_request_url('findItemsByKeywords', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByProduct.html
    def find_items_by_product(params)
      raise ArgumentError unless params[:productId]
      params['productId.@type'] = 'ReferenceID'
      get_json_response(build_request_url('findItemsByProduct', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsIneBayStores.html
    def find_items_in_ebay_stores(params)
      raise ArgumentError unless params[:keywords] or params[:storeName]
      get_json_response(build_request_url('findItemsIneBayStores', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getHistograms.html
    def get_histograms(params)
      raise ArgumentError unless params[:categoryId]
      get_json_response(build_request_url('getHistograms', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getSearchKeywordsRecommendation.html
    def get_search_keywords_recommendation(params)
      raise ArgumentError unless params[:keywords]
      get_json_response(build_request_url('getSearchKeywordsRecommendation', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getVersion.html
    def get_version
      get_json_response(build_request_url('getVersion'))
    end
    
    private
    def build_request_url(service, params=nil)
      url = "#{BASE_URL}?OPERATION-NAME=#{service}&SERVICE-VERSION=#{VERSION}&SECURITY-APPNAME=#{Rebay::Api.app_id}ID&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      url += build_rest_payload(params)
      return url
    end
    
    def transform_json_response(response)    
      if response.class == Hash
        r = Hash.new
        response.keys.each do |k|
          r[k.to_sym] = transform_json_response(response[k])
        end
        return r
      elsif response.class == Array and response.size == 1  
        return transform_json_response(response[0])
      else
        return response
      end
    end
  end
end