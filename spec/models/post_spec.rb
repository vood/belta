#encoding: utf-8
require 'spec_helper'

describe Post do
  describe ".create_or_update_by_source" do
    it "creates new record if record with such source does not exist and attaches it to category" do
      Post.find_by_source('http://text.com').should be_nil
      post = Post.create_or_update_by_source(:source => 'http://text.com')
      Post.find_by_source('http://text.com').should eq(post)
    end

    it "creates new record which has related post with the same title" do
      existed_post = Factory(:post, :title => 'тестирование')
      post = Post.create_or_update_by_source(:title => 'тестирование', :source => 'http://text.com')
      existed_post.related.first.should eq(post)
    end
  end
end
