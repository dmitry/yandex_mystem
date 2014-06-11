require 'open3'
require 'yandex_mystem/version'
require 'pathname'
require 'json'

module YandexMystem
  class Base    

    def self.stem(text)
      exec = [command, self::ARGUMENTS].join(' ')

      data = Open3.popen3(exec) do |stdin, stdout, _|
        stdin.write text
        stdin.close
        stdout.read
      end

      parse(data)
    end

    def self.command
      @command ||= begin
        path = Pathname.new(__FILE__) + '../../bin/'
        path + "mystem-#{command_postfix}"
      end
    end

    def self.command_postfix
      @command_postfix ||= case RUBY_PLATFORM
        when /(win|w)32$/
          'win.exe'
        when /32.+linux$|i[46]86.+linux$/
          'linux-32'
        when /64.+linux$/
          'linux-64'
        when /darwin/
          raise 'Mystem 3.0 does not support Max OS X.'
        when /freebsd/
          'bsd'
        else
          raise 'Unknown OS'
        end
    end
  end

  class Simple < Base
    ARGUMENTS = '-e utf-8 --format json'    


    def self.parse(data)
      Hash[ JSON.parse(data, :symbolize_names => true).inject([]){|s, h| s + [[ h[:text], h[:analysis].map{|a| a[:lex]} ]]}  ]
    end
  end

  class Raw < Base
    ARGUMENTS = '-e utf-8 -ig --weight --format json --eng-gr'        

    def self.parse(data)
      JSON.parse data, :symbolize_names => true
    end    
  end
end
