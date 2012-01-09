require 'open3'
require 'yandex_mystem/version'

module YandexMystem
  class Base
    # TODO add -i
    def self.stem(text)
      exec = Array(command).tap do |c|
        c << '-e utf-8 -n'
      end.join(' ')

      data = Open3.popen3(exec) do |stdin, stdout, stderr|
        stdin.write text
        stdin.close
        #stderr.read
        stdout.read
      end

      data = data.scan(/^([^\{]+)\{(.+)\}$/).map do |(word, words)|
        words = words.split('|').select do |w|
          !(w =~ /.+\?\?$/)
        end

        [word, words]
      end.flatten(1)

      Hash[*data]
    end

    private

    def self.command
      postfix = if RUBY_PLATFORM =~ /(win|w)32$/
                  'win.exe'
                elsif RUBY_PLATFORM =~ /32.+linux$/
                  'linux-32'
                elsif RUBY_PLATFORM =~ /64.+linux$/
                  'linux-64'
                elsif RUBY_PLATFORM =~ /darwin/
                  'mac'
                elsif RUBY_PLATFORM =~ /freebsd/
                  raise 'Create an issue or add pull request on a github.'
                else
                  raise 'Unknown OS'
                end

      path = Pathname.new(__FILE__) + '../../app/'
      path + "mystem-#{postfix}"
    end
  end
end
