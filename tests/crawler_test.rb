require 'minitest/autorun'
require 'minitest/pride'
require './lib/crawler'

class CrawlerTest < Minitest::Test
  # def test_crawler_output_condition
  #   crawler = Crawler.new
  #   assert crawler.crawler(1,1)
  # end

  def test_crawler_conditions_pass
    crawler = Crawler.new
    assert crawler.crawler(1,1)
  end
end
