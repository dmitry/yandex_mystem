require 'open3'
require 'yandex_mystem/version'
require 'pathname'

module YandexMystem
  class Base
    WORD_SCANNER_REGEXP = /^([^\{]+)\{(.+)\}$/.freeze

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
        path = Pathname.new(__FILE__) + '../../app/'
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
          'mac'
        when /freebsd/
          raise 'Create an issue or add pull request on a github.'
        else
          raise 'Unknown OS'
        end
    end
  end

  class Simple < Base
    ARGUMENTS = '-e utf-8 -n'

    NOT_INCLUDE_REGEXP = /.+\?\?$/.freeze


    def self.parse(data)
      parsed = data.scan(WORD_SCANNER_REGEXP).map do |(word, words)|
        words = words.split('|').select do |w|
          !(w =~ NOT_INCLUDE_REGEXP)
        end

        [word, words]
      end.flatten(1)

      Hash[*parsed]
    end
  end

  class Extended < Base
    ARGUMENTS = '-e utf-8 -nifg'

    REGEXP = /([^\|:]+):([0-9\.]+)=([A-Z]+)/

    Word = Struct.new(:word, :frequency, :part)

    def self.parse(data)
      parsed = {}

      data.scan(WORD_SCANNER_REGEXP).each do |(word, words)|
        unless parsed.key?(word)
          words = words.scan(REGEXP).map do |w|
            to_word(w)
          end

          unless words.size.zero?
            parsed[word] = words.sort_by(&:frequency).reverse
          end
        end
      end

      parsed
    end

    private

    def self.to_word(w)
      word, frequency, part = w
      Word.new(word, frequency.to_f, part)
    end
  end
end
