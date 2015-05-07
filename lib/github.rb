require 'httparty'
require 'json'

class Github
  class Json
    def self.parse(argv)
      { user_name:        argv[0],
        output_filename:  argv[1],
        repo_names:       argv[2].to_s.split(",")
      }
    end

    def self.run(argv,stdout)
      options = parse(argv)
      require 'pry'
      binding.pry
      if argv[2] == nil
        call(options)
      else
        call_contributors(options)
      end
      stdout.puts "Successfully wrote the data to #{options[:output_filename]}!"
    end

    def self.call(options)
      response = HTTParty.get(repo_url_for(options), { :headers => {"User-Agent" => "HTTPARTY"}})
      file = File.open(options[:output_filename],"w")
      file.write response.to_json
      file.close
      response
      0
    end
    
    def self.call_contributors(options)
      file = File.open(options[:output_filename],"w")
      file.write repos_contributors(options).to_json 
      file.close
    end

    def self.contributors(options,repo_name,response=[],page_number=1)
      first_page = HTTParty.get(contributors_url_for(options,repo_name), { :headers => {"User-Agent" => "HTTPARTY"}})
      binding.pry
      response << first_page
      if first_page.headers["link"] != nil
        number_of_pages = first_page.headers["link"].split(",")[1].match(/&page=(\d+)/)[1].to_i
        loop do
          response << HTTParty.get(contributors_url_for(options,repo_name), { :query => {page: page_number += 1}, :headers => {"User-Agent" => "HTTPARTY"}})
          break if page_number >= number_of_pages
        end
      end
      response = response.flatten
      response.each {|contributor| contributor["repo"] = "#{repo_name}"}
    end
    
    def self.repos_contributors(options,list=[])
      options[:repo_names].each do |repo_name|
        response = contributors(options,repo_name)
        response = response.flatten
        list << response
      end
      list.flatten
    end

    def self.contributors_url_for(options,repo_name)
      "https://api.github.com/repos/#{options[:user_name]}/#{repo_name}/contributors?per_page=100"
    end

    def self.repo_url_for(options)
      "https://api.github.com/users/#{options[:user_name]}/repos?per_page=100"
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
