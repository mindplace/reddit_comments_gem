require "reddit_comments/version"
require 'net/http'
require 'open-uri'
require 'json'

module RedditComments
  def self.recursive_comment_digging(child, comments=[])
    post = {}
    post["id"] = child["id"]
    post["author"] = child["author"]
    post["body"] = child["body"]
    post["parent_id"] = child["parent_id"]

    comments << post

    if child["replies"] != nil && child["replies"] != ""
      child["replies"]["data"]["children"].each do |comment|
        comments << self.recursive_comment_digging(comment["data"])
      end
    end
    comments
  end

  def self.append_json(link)
    unless link.match(/\/.json\z/)
      link = link + "/.json"
    end
    link
  end

  def self.parse_post(post)
    post = self.append_json(post)

    uri = URI.parse(post.dup)
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "Reddit_Comments_Gem_0.1_mindplace"})
    body = http.request(request)
    JSON.parse(body.body)
  end

  def self.get_comments(post)
    comments = []
    post[1]["data"]["children"].each do |child|
      comments << recursive_comment_digging(child["data"])
    end
    comments.flatten
  end

  def self.retrieve(link)
    post = self.parse_post(link)
    self.get_comments(post)
  end
end
