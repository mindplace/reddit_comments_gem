# RedditComments

Use this gem to pull in Reddit comments from a given Reddit page.
The comments will appear as an array of hashes, where each hash has the following:
- comment id
- comment author
- comment text
- parent id

The parent id refers to the thing that the comment was made on: so if it was a comment on the original post, the id will refer
to that, otherwise it will refer to the comment on which THIS comment was made.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reddit_comments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reddit_comments

## Usage

Get the URL of the page from which you would like to retrieve comments. The URL should look something like this:

```ruby
  url = "https://www.reddit.com/r/worldnews/comments/4ozup2/cracks_emerge_in_the_european_consensus_on_russia/"
```

(The gem will append ```/.json``` to your URL unless you feed it a link with the ```/.json``` already appended.)

```ruby
RedditComments.retrieve(url)
```

### Example usage:

```ruby
require 'reddit_comments'

url = "https://www.reddit.com/r/worldnews/comments/4ozup2/cracks_emerge_in_the_european_consensus_on_russia/"

RedditComments.retrieve(url)
```
Result:

```wrap:space
[
  {"id"=>"d4gvid3",
 "parent_id"=>"t3_4ozup2"
 "author"=>"extremelycynical",
 "body"=>"As a European (and German, considering the content of the article) I can only say that I find it completely unacceptable that we impose sanctions on Russia. \n\nIt's nothing but the blind application of glaringly obvious and undeniable double standards as well as mind-boggling hypocrisy.\n\nRussia annexing Crimea is a move that by the best estimates can only be called *supported* by the Crimean people and a direct response to escalating US destabilization in the region akin to the destabilization it caused in Syria. Russia saw that the US took away Tartus and the Golan Heights and now wants to take away Sevastopol and put an end to it. And those sanctions come without regarding the wishes of the Crimean people or in any way negotiating with Russia.\n\nIf we sanction Russia why don't we sanction Israel? (A nation that is committing far worse crimes and is annexing more and more land constantly?) \nWhy don't we sanction the US? A warmongering nation that is committing war crimes and is violating the fundamental human rights of any internet user?  \nWhy don't we sanction Saudi Arabia? A country supporting radical Islam and terrorism?\n\nIt is quite undeniable that these sanctions are entirely based on US interests and the anti-Russian agenda pushed for by that country. These sanctions do not contribute to peace. These sanctions don't exist for humanitarian reasons and us caring about human rights. These sanctions don't even exist because anyone actually believes that Russia deserves them. They exist because the West hates Russia. And we need to stop pretending that Russia deserves our sanctions any more than countries like Israel, the US or Saudi Arabia. And we need to face the fact that before we sanction Russia we should first of all sanction those kind of countries."},

 {"id"=>"d4gx7w3",
  "parent_id"=>"t1_d4gvid3"
  "author"=>"Esquina1",
  "body"=>"Good points! I may add that in my view the Crimean case is the correction of a late Soviet-Union-internal mistake which should be solved bilaterally between the sucessors of the Soviet-Union. As for the East Ukrainian secesssion areas, Russia should find a solution to pull out and help with convincing evidence to solve the MH 17 case and indemnify the bereaved."},

  {"id"=>"d4gxtf8",
   "parent_id"=>"t1_d4gvid3"
   "author"=>"princefalcon",
   "body"=>"&gt;\nIt is quite undeniable that these sanctions are entirely based on US interests \n&gt;\n\nNot entirely surely? Russia ruled what are now the Ukraine, the Baltic republics, Belarus, Poland right through the 19C as a result of being one of the European great powers and the tendency for the more powerful states to get what they wanted back then. Some of those ethnicities became independent countries after WW1, but got forced into membership of the Warsaw Pact after WW2, so were directly ruled by the USSR or were satellites. There is some doubt about how much Russia respects the principle of national sovereignty. Ideally Russia itself would join the EU so that we could be a happy family of nations, but that doesn't seem likely."}
  ]
```

## Contributing

Bug reports, pull requests, and feature requests are welcome. Please fork this repo, pull down to your local machine from your fork, push up your changes, and make a pull request from your fork to this repo.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
