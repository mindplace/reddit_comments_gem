require "reddit_comments/version"
require 'net/http'
require 'open-uri'
require 'json'

module RedditComments
  class IncorrectLinkFormat < StandardError; end

  class GetComments
    attr_accessor :url, :comments, :request

    def initialize(url)
      @url = url
      @comments = []
    end

    def recursive_comment_digging(child, comments=[])
      post = {}
      post["id"] = child["id"]
      post["parent_id"] = child["parent_id"]
      post["author"] = child["author"]
      post["body"] = child["body"]

      comments << post

      if child["replies"] != nil && child["replies"] != ""
        child["replies"]["data"]["children"].each do |comment|
          comments << self.recursive_comment_digging(comment["data"])
        end
      end
      comments
    end

    def get_comments
      @post[1]["data"]["children"].each do |child|
        @comments << recursive_comment_digging(child["data"])
      end
      @comments = comments.flatten
    end

    def parse_post
      uri = URI.parse(url.dup)
      http = Net::HTTP.new(uri.host)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.initialize_http_header({"User-Agent" => "Reddit_Comments_Gem_0.1_mindplace"})
      body = http.request(request)
      @post = JSON.parse(body.body)
    end

    def append_json
      unless url.match(/\/.json\z/)
        if url[-1] == "/"
          @url = url + ".json"
        else
          @url = url + "/.json"
        end
      end
    end

    def link_tested
      unless url.match(/https:\/\/www.reddit.com\/r\/(.*)\/comments\/(.*)\/(.*)\//)
        raise IncorrectLinkFormat, "Not an acceptable Reddit link, please see documentation."
      end
    end

    def retrieve
      link_tested
      append_json
      parse_post
      get_comments
    end
  end

  def self.retrieve(link)
    comments = GetComments.new(link)
    comments.retrieve
  end
end
