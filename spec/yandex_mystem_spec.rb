# encoding: utf-8
require 'spec_helper'

describe YandexMystem do
  context YandexMystem::Simple do
    it "should stem words" do
      data = YandexMystem::Simple.stem('мальчики мальчиков девочки девочек компьютеров компьютере сов пошли elements')
      data['мальчики'].should eq %w(мальчик)
      data['мальчиков'].should eq %w(мальчик мальчиков мальчиковый)
      data['девочки'].should eq %w(девочка)
      data['девочек'].should eq %w(девочка)
      data['сов'].should eq %w(сова)
      data['пошли'].should eq %w(пойти посылать)
      data['elements'].should eq []
    end
  end

  context YandexMystem::Extended do
    it 'latin words' do
      words = YandexMystem::Extended.stem('elements')

      words.size.should eq 0

      words['elements'].should be_nil
    end

    it 'multiple definitions' do
      words = YandexMystem::Extended.stem('девочка мальчиков пошла к комьютерам искать, в прочем, как и всегда')

      words.size.should eq 11

      words['девочка'].first.word.should eq 'девочка'
      words['девочка'].first.frequency.should eq 185.2
      words['девочка'].first.part.should eq 'S'


      words['мальчиков'].size.should eq 3
    end

    it 'sort by frequency' do
      words = YandexMystem::Extended.stem('сосланный')

      words['сосланный'].size.should eq 2

      words['сосланный'].map(&:word).should eq %w(ссылать сосланный)
      words['сосланный'].map(&:frequency).should eq [1.2, 0.5]
      words['сосланный'].map(&:part).should eq %w(V S)
    end

    it 'set multiple times the same word, but lowercase and uppercase is different' do
      YandexMystem::Extended.should_receive(:to_word).exactly(4).times.and_return(YandexMystem::Extended.const_get(:Word).new('в', 2, 'S'))
      YandexMystem::Extended.stem('В в в в')
    end
  end
end
