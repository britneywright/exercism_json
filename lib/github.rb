require 'httparty'
require 'json'

class Github
  class Json
    def self.parse(argv)
      { user_name:        argv[0],
        output_filename:  argv[1],
        repo_name:        argv[2]
      }
    end

    def self.run(argv,stdout)
      options = parse(argv)
      if argv[2] == nil
        call(options)
      else
        all_contributors(options)
      end
      stdout.puts "Successfully wrote the data to #{options[:output_filename]}!"
    end

    def self.call(options)
      response = HTTParty.get(url_for(options), { :headers => {"User-Agent" => "HTTPARTY"}})
      file = File.open(options[:output_filename],"w")
      file.write response.to_json
      file.close
      response
      0
    end

    def self.all_contributors(options)
      response = []
      first_page = HTTParty.get(contributors_url_for(options), { :headers => {"User-Agent" => "HTTPARTY"}})
      response << first_page
      if first_page.headers["link"] != nil
        number_of_pages = first_page.headers["link"].split(",")[1].match(/&page=(\d+)/)[1].to_i
        page_number = 1
        loop do
          response << HTTParty.get(contributors_url_for(options), { :query => {page: page_number += 1}, :headers => {"User-Agent" => "HTTPARTY"}})
          break if page_number >= number_of_pages
        end
      end
      file = File.open(options[:output_filename],"w")
      file.write response.flatten.to_json
      file.close
    end

    def self.url_for(options)
      "https://api.github.com/users/#{options[:user_name]}/repos?per_page=100"
    end

    def self.contributors_url_for(options)
      "https://api.github.com/repos/#{options[:user_name]}/#{options[:repo_name]}/contributors?per_page=100"
    end
  end

  class HashAttributes 
    attr_accessor :attributes

    def self.getter_from_attribute(*getter_names)
      getter_names.each do |name|
        define_method(name) { attributes[name] }
      end
    end

    def initialize(attributes)
      self.attributes = attributes
    end
  end

  class Repo < HashAttributes
    getter_from_attribute :id,
                          :name,
                          :full_name,
                          :html_url,
                          :description,
                          :url,
                          :contributors_url,
                          :created_at,
                          :updated_at,
                          :size  
  end

  class Contributor < HashAttributes
    getter_from_attribute :login,
                          :id,
                          :avatar_url,
                          :contributions,
                          :repo
  end
end
