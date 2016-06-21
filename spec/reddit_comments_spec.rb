require 'spec_helper'
require 'pry'
require 'json'

describe RedditComments do
  it 'has a version number' do
    expect(RedditComments::VERSION).not_to be nil
  end

  describe 'self.link_tested' do
    it 'raises error if given a non-Reddit link' do
      url = 'http://www.example.com'
      expect{ RedditComments.link_tested(url) }.to raise_error(RedditComments::IncorrectLinkFormat)
    end

    it 'raises error for Reddit link if not correct format' do
      url = 'https://www.reddit.com/r/worldnews/comments/were_living_worse_than_in_a_war_venezuelas/'
      expect{ RedditComments.link_tested(url) }.to raise_error(RedditComments::IncorrectLinkFormat)
    end

    it 'passes an acceptabe Reddit link' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/'
      expect{ RedditComments.link_tested(url) }.not_to raise_error
    end
  end

  describe 'self.append_json' do
    it 'appends .json to the link if not present' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/'
      updated = url + '.json'
      expect(RedditComments.append_json(url)).to eq(updated)
    end

    it 'does not append if present' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/.json'
      expect(RedditComments.append_json(url)).to eq(url)
    end
  end

  describe 'self.parse_post' do
    it 'takes a url and returns JSON object of url content' do
      url = 'https://www.reddit.com/r/worldnews/comments/4p4orb/were_living_worse_than_in_a_war_venezuelas/.json'
      result = RedditComments.parse_post(url)
      expect(result).to be_an_instance_of(Array)
      expect(result[0]).to be_an_instance_of(Hash)
    end
  end

  describe 'self.get_comments' do
    let(:post_body) { RedditComments.parse_post("https://www.reddit.com/r/worldnews/comments/4p71mu/migrant_protests_calais_france_tried_to_force_way/.json")}
    let(:comments) { RedditComments.get_comments(post_body) }

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
