require 'rubygems'
require 'sinatra'

get '/' do
   redirect '/rss'
end

get 'rss' do
   @site_url        = 'http://b.com'
   @xml_title       = 'News'
   @xml_description = 'Shiny News'
  
   # TODO
   # create @posts objects based on parsing a particular folder on the FS

   builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => "2.0" do
         xml.channel do
            xml.title @xml_title
            xml.description @xml_description
            xml.link @site_url
            @posts.each do |post|
               xml.item do
                  xml.title post.title
                  xml.link "#{@site_url}/posts/#{post.id}"
                  xml.description post.body
                  xml.pubDate Time.parse(post.created_at.to_s).rfc822()
                  xml.guid "#{@site_url}/posts/#{post.id}"
               end
            end
         end
      end
   end
end

