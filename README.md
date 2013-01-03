rebay
========
Rebay is a very simple wrapper for the ebay finding and shopping APIs.  Please see the ebay documentation for the proper input arguments and expected output. 

[Ebay Shopping Api Documentation](http://developer.ebay.com/products/shopping/)

[Ebay Finding Api Documentation](http://developer.ebay.com/products/finding/)

Configuration
-------------
Create and require a config.rb, or if using rails create an initializer (rebay.rb perhaps), and place the following code into it:

	Rebay::Api.configure do |rebay|
		rebay.app_id = 'YOUR APPLICATION ID HERE'
	end
		
		
Use
---
If you have questions about optional/required parameters, please check the ebay api docs.  The source of this api wrapper also includes links to specific api call documentation.  Basically, pass whatever options into the rebay api call and they will be passed through into the actual api call.  When getting your return response, the json from ebay is transformed just a bit.  You can still expect the same keys to come through in the hash, they just aren't annoyingly wrapped in an array... everywhere.


Example
-------
To get search keyword recommendations for *acordian*:

	finder = Rebay::Finding.new
	response = finder.get_search_keywords_recommendation({:keywords => 'acordian'})
	
Ebay will return an array filled result something like this:
		
	{"getSearchKeywordsRecommendationResponse": [{"ack": ["Success"],"version": ["1.5.0"],"timestamp": ["2010-08-13T21:11:02.539Z"],"keywords": ["accordion"]}]}
	
For my own sanity, I transform this response into a more standard ruby hash and in the case of the finding api responses, I removed the XXXResponse key and use the resulting hash as the response (to be inline with the shopping api responses).

	{"ack" => "Success", "version" => "1.5.0", "timestamp" => "2010-08-13T21:11:02.539Z", "keywords" => "accordion"}

You can check for success or failure of the request:
	response.success?
	response.failure?
  
Recent Updates
--------------
[yarmiganosca](https://github.com/yarmiganosca)

  Added support for using Ebay Sandbox urls (through a configuration
  variable).

  Changed the way Finding and Shopping generate their base urls. Instead
  of a class variable, they now call self.base_url, which reads the
  sandbox configuration variable and either creates a sandbox url or a
  production url.
  
  Updated the conditions under which the Shopping Api calls raise
  ArgumentErrors, involved changing the cases of the parameters (they
  changed in the Ebay Api) and adding support for specifying either a
  ProductID or a ProductID.type, ProductID.Value pair for searching by
  ProductIDs other than Ebay ReferenceIDs.
  
[peppyheppy](https://github.com/peppyheppy)

  Added support for dynamic siteid in both configuration and by passing in params
  
MIT License
-----------
Copyright (c) 2010 Chuck Collins

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.