#encoding: utf-8
require 'spec_helper'

describe CrawlerController do
  describe "GET index" do
    it "parses @feeds and creates @posts" do
      Factory(:feed, :url => 'response.html')
      category = Factory(:category, :title => 'test', :tag_list => 'expected')
      get :index
      post = assigns(:posts).first
    end
  end
end
