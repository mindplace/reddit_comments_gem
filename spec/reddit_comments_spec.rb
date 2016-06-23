require 'spec_helper'
require 'pry'

describe RedditComments do
  it 'has a version number' do
    expect(RedditComments::VERSION).not_to be nil
  end

  describe 'link_tested' do
    it 'raises error if given a non-Reddit link' do
      url = 'http://www.example.com'
      reddit_comments = RedditComments::GetComments.new(url)

      expect{ reddit_comments.link_tested }.to raise_error(RedditComments::IncorrectLinkFormat)
    end

    it 'raises error for Reddit link if not correct format' do
      url = 'https://www.reddit.com/r/worldnews/comments/were_living_worse_than_in_a_war_venezuelas/'
      reddit_comments = RedditComments::GetComments.new(url)

      expect{ reddit_comments.link_tested }.to raise_error(RedditComments::IncorrectLinkFormat)
    end

    it 'passes an acceptabe Reddit link' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/'
      reddit_comments = RedditComments::GetComments.new(url)

      expect{ reddit_comments.link_tested }.not_to raise_error
    end
  end

  describe 'append_json' do
    it 'appends .json to the link if not present' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/'
      updated = url + '.json'
      reddit_comments = RedditComments::GetComments.new(url)
      reddit_comments.append_json

      expect(reddit_comments.url).to eq(updated)
    end

    it 'does not append if present' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/.json'
      reddit_comments = RedditComments::GetComments.new(url)
      reddit_comments.append_json

      expect(reddit_comments.url).to eq(url)
    end
  end

  describe 'parse_post' do
    it 'takes a url and returns JSON object of url content' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/.json'
      reddit_comments = RedditComments::GetComments.new(url)
      reddit_comments.parse_post

      expect(reddit_comments.post).to be_an_instance_of(Array)
      expect(reddit_comments.post[0]).to be_an_instance_of(Hash)
    end
  end

  describe 'get_comments' do
    let(:url) { "https://www.reddit.com/r/worldnews/comments/4p71mu/migrant_protests_calais_france_tried_to_force_way/.json" }
    let(:comments) { RedditComments::GetComments.new(url).retrieve }

    it 'returns an array of comment hashes' do
      expect(comments).to be_an_instance_of(Array)

      comments.each do |comment|
        expect(comment).to be_an_instance_of(Hash)
      end
    end

    it 'includes expected comment text' do
      comment = comments.select{|c| c["body"] == "That moment you realize brexit does nothing to stop this."}
      expect(comment).not_to be_empty
    end
  end
end
