require 'feedzirra'

feeds_urls = [
"http://www.comoinstalarlinux.com/feed/",
"http://www.atareao.es/feed/",
"http://feeds.feedburner.com/blogalejandrocq?format=xml",
"http://chicheblog.wordpress.com/feed/",
"http://feeds.feedburner.com/emsLinux?format=xml",
"http://encodingthecode.wordpress.com/feed/",
"http://feeds.feedburner.com/EspacioLinux?format=xml",
"http://hatteras.wordpress.com/feed/",
"http://isopenisfree.wordpress.com/feed/",
"http://feeds.feedburner.com/JhosmanLizarazo?format=xml",
"http://feeds.feedburner.com/blogspot/eEKCUv?format=xml",
"http://feeds.feedburner.com/Kuyn?format=xml",
"http://feeds.feedburner.com/blogspot/eEKCUv?format=xml",
"http://libuntu.wordpress.com/feed/",
"http://feeds.feedburner.com/LinuxMusic30?format=xml",
"http://www.muylinux.com/feed/",
"http://netfaozz.wordpress.com/feed/",
"http://feeds.feedburner.com/NoSoloUnix?format=xml",
"http://feeds.feedburner.com/Nosinmiubuntu?format=xml",
"http://feeds.feedburner.com/NovatillaenApuros?format=xml",
"http://ociolinux.blogspot.mx//feeds/posts/default",
"http://feed.mundogeek.net/mundogeekfeed?format=xml",
"http://feeds.feedburner.com/PortalUbuntu?format=xml",
"http://elsoftwarelibre.wordpress.com/feed/",
"http://www.soloubuntu.com/feeds/posts/default",
"http://feeds2.feedburner.com/Ubunlog?format=xml",
"http://ubunteate.es/feed/",
"http://feeds.feedburner.com/blogspot/JOzz?format=xml",
"http://dmolinap.blogspot.mx/rss.xml",
"http://www.ubuntuleon.com/feeds/posts/default",
"http://ubuntulife.wordpress.com/feed/",
"http://ubuntutoday.com/feed/",
"http://portallinux.es/feed/",
"http://unawebmaslibre.blogspot.com/feeds/posts/default",
"http://feeds.feedburner.com/UsemosLinux?format=xml"
]

namespace :blogsinfo  do
  desc "Gets blogs info"
  task :get => :environment do
    blogs = []
    feeds = Feedzirra::Feed.fetch_and_parse(feeds_urls)
    feeds.each do |feed_url, feed|
      unless Blog.where(:feed_url => feed_url)
        blogs << {
          :title => feed.title,
          :url => feed.url,
          :feed_url => feed_url
        }
      end
    end
    if (Blog.create(blogs))
      puts "Success!"
      puts "Array: #{blogs.count}"
      puts "Database: #{Blog.count}"
    else
      puts "Something went wrong"
    end
  end
  task :show => :environment do
    Blog.all.each do |blog|
      puts blog.title
      puts blog.url
      puts blog.feed_url
      puts "========="
    end
  end
end

namespace :update do
  desc "Update blogs"
  task :posts => :environment do
    feeds_urls = []
    Blog.all.each do |blog|
      feeds_urls << blog.feed_url
    end
    feeds = Feedzirra::Feed.fetch_and_parse(feeds_urls)
    feeds.each do |feed_url, feed|
      feed.entries.each do |entry|
        title = entry.title
        link = entry.url
        unless entry.summary.nil?
          description = entry.summary.sanitize[0..140]
        end
        pubdate = entry.published
      end
    end
  end
end
