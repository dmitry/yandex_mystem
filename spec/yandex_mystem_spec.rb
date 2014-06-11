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

  context YandexMystem::Raw do
    it 'latin words' do
      response = YandexMystem::Raw.stem('Elements')

      response.size.should eq 1
      response[0][:analysis].should eq []      
      response[0][:text].should eq 'Elements'      
    end

    it 'multiple definitions' do
      response = YandexMystem::Raw.stem('девочка мальчиков пошла к комьютерам искать, в прочем, как и всегда')

      response.size.should eq 11

      response.find_all{|h| h[:text] == 'девочка'}.first[:analysis].first[:lex].should eq 'девочка'
      response.find_all{|h| h[:text] == 'девочка'}.first[:analysis].first[:wt].should eq 1
      response.find_all{|h| h[:text] == 'девочка'}.first[:analysis].first[:gr].should eq 'S,f,anim=nom,sg'      

      response.find_all{|h| h[:text] == 'мальчиков'}.first[:analysis].size.should eq 3
    end

    it 'get geo name' do
      response = YandexMystem::Raw.stem('Москва')
      response.find_all{|h| h[:text] == 'Москва'}.first[:analysis].first[:gr].should include 'geo'
    end


  end
end
