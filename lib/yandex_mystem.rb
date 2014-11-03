# encoding: utf-8

require 'open3'
require 'yandex_mystem/version'
require 'pathname'
require 'oj'

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
          'osx'
        when /freebsd/
          'bsd'
        else
          raise 'Unknown OS'
        end
    end

    def self.as_json(data)
      Oj.load("[#{data.split("\n").join(',')}]", symbol_keys: true)
    end
  end

  class Simple < Base
    ARGUMENTS = '-e utf-8 -n --format json'    


    def self.parse(data)
      Hash[
        as_json(data).map do |h|
          [
            h[:text],
            h[:analysis].map { |a| a[:lex] }
          ]
        end
      ]
    end
  end

  class Raw < Base
    ARGUMENTS = '-e utf-8 -ig -n --weight --format json --eng-gr'        

    def self.parse(data)
      as_json(data)
    end    
  end
end
