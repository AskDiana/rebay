require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Finding do
    it "should specify base url" do
      Finding::BASE_URL.should_not be_nil
    end
    
    context "on creation" do      
      it "should return app id" do
        Rebay::Api.configure do |rebay|
          rebay.app_id = 'test'
        end
        Rebay::Api.app_id.should == 'test'
      end
    end
    
    context "after creation" do
      before(:each) do
        @finder = Finding.new
      end
      
      it "should provide find_items_advanced" do
        @finder.should respond_to(:find_items_advanced)
      end
      
      it "should provide find_items_by_category" do
        @finder.should respond_to(:find_items_by_category)
      end
      
      it "should provide find_items_by_product" do
        @finder.should respond_to(:find_items_by_product)
      end
      
      it "should provide find_items_in_ebay_stores" do
        @finder.should respond_to(:find_items_in_ebay_stores)
      end
      
      it "should provide get_histograms" do
        @finder.should respond_to(:get_histograms)
      end
      
      it "should provide get_search_keywords_recommendation" do
        @finder.should respond_to(:get_search_keywords_recommendation)
      end
      
      it "should provide get_version" do
        @finder.should respond_to(:get_version)
      end
    end
    
    context "when calling find_items_advanced" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without storeName or keywords defined" do
        lambda { @finder.find_items_advanced }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response with categoryId as parameter" do
        @finder.find_items_advanced({:categoryId => 1}).class.should eq(Hash)
      end
      
      it "should return a hash response with keywords as parameter" do
        @finder.find_items_advanced({:keywords => 'feist'}).class.should eq(Hash)
      end
    end
    
    context "when calling find_items_by_category" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without category_id" do
        lambda { @finder.get_search_keywords_recommendation }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_category({:categoryId => 1}).class.should eq(Hash)
      end
    end
    
    context "when calling find_items_by_product" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without product_id" do
        lambda { @finder.find_items_by_product }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_product({:productId => 53039031}).class.should eq(Hash)
      end
    end
  
    context "when calling find_items_by_keywords" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without keywords" do
        lambda { @finder.find_items_by_keywords }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_keywords({:keywords => 'feist'}).class.should eq(Hash)
      end
    end
    
    context "when calling find_items_in_ebay_stores" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without storeName or keywords defined" do
        lambda { @finder.find_items_in_ebay_stores }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response with storeName as parameter" do
        @finder.find_items_in_ebay_stores({:storeName => 'Laura_Chen\'s_Small_Store'}).class.should eq(Hash)
      end
      
      it "should return a hash response with keywords as parameter" do
        @finder.find_items_in_ebay_stores({:keywords => 'feist'}).class.should eq(Hash)
      end
    end
    
    context "when calling get_histograms" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without category_id" do
        lambda { @finder.get_histograms }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.get_histograms({:categoryId => 1}).class.should eq(Hash)
      end
    end
    
    context "when calling get_search_keywords_recommendation" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should fail without keywords" do
        lambda { @finder.get_search_keywords_recommendation }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.get_search_keywords_recommendation({:keywords => 'feist'}).class.should eq(Hash)
      end
    end
    
    context "when parsing response" do
      before(:each)  do
        @json_happy = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_happy.json'))
        @json_sad = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_sad.json'))
        @finder = Finding.new
      end
      
      it "should transform the happy json" do
        happy = @finder.send :transform_json_response, @json_happy
        happy.should eq({:getSearchKeywordsRecommendationResponse => {:ack => "Success", :version => "1.5.0", 
                                                                      :timestamp => "2010-08-13T21:11:02.539Z", :keywords => "accordion"}})
      end
      
      it "should transform the sad json" do
        sad = @finder.send :transform_json_response, @json_sad
        sad.should eq({:getSearchKeywordsRecommendationResponse =>
                        {:ack => "Warning",
                         :errorMessage => {:error => {:errorId => "59", :domain => "Marketplace", :severity => "Warning",
                                                      :category => "Request", :message => "No recommendation was identified for the submitted keywords.",
                                                      :subdomain => "Search"}},
                         :version => "1.5.0",
                         :timestamp => "2010-08-13T21:08:30.081Z",
                         :keywords => ""}})
      end
    end
    
    context "when calling get_version" do
      before(:each) do 
        @finder = Finding.new
      end
      
      it "should return a hash response" do
        @finder.get_version.class.should eq(Hash)
      end
    end
  end
end
