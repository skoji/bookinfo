require "spec_helper"

describe Bookinfo do
  it "has a version number" do
    expect(Bookinfo::VERSION).not_to be nil
  end

  if ENV['DO_AMAZON_TEST'] 
    describe 'Test Amazon API' do
      it "should get valid amazon link" do
        Bookinfo.configure do |options|
          options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
          options[:AWS_secret_key] = ENV['AWS_SECRET_KEY']
          options[:associate_tag] = ENV['AMAZON_ASSOCIATE_TAG']
        end
        info = Bookinfo.get_info('978-4153350281')
        expect(info.amazon_links).to contain_exactly "https://www.amazon.co.jp/dp/4153350281?tag=#{ENV['AMAZON_ASSOCIATE_TAG']}",
                                                     "https://www.amazon.co.jp/dp/B01KYZIPY8?tag=#{ENV['AMAZON_ASSOCIATE_TAG']}"
      end
    end
  end
end
