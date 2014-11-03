# encoding: utf-8
require 'spec_helper'

describe YandexMystem do
  context YandexMystem::Simple do
    it 'should stem words' do
      data = YandexMystem::Simple.stem("мальчики мальчиков девочки девочек компьютеров компьютере сов пошли elements")

      expect(data['мальчики']).to eq %w(мальчик)
      expect(data['мальчиков']).to eq %w(мальчик мальчиков мальчиковый)
      expect(data['девочки']).to eq %w(девочка)
      expect(data['девочек']).to eq %w(девочка)
      expect(data['сов']).to eq %w(сова)
      expect(data['пошли']).to eq %w(пойти посылать)
      expect(data['elements']).to eq []
    end
    
    it 'should stem words in few lines' do
      data = YandexMystem::Simple.stem('
        мальчики
        мальчиков
        девочки
        девочек
        компьютеров
        компьютере
        сов
        пошли
        elements
      ')

      expect(data['мальчики']).to eq %w(мальчик)
      expect(data['мальчиков']).to eq %w(мальчик мальчиков мальчиковый)
      expect(data['девочки']).to eq %w(девочка)
      expect(data['девочек']).to eq %w(девочка)
      expect(data['компьютере']).to eq %w(компьютер)
      expect(data['сов']).to eq %w(сова)
      expect(data['пошли']).to eq %w(пойти посылать)
      expect(data['elements']).to eq []
    end
  end

  context YandexMystem::Raw do
    it 'latin words' do
      response = YandexMystem::Raw.stem('Elements')

      expect(response.size).to eq 1
      expect(response[0][:analysis]).to eq []
      expect(response[0][:text]).to eq 'Elements'
    end

    it 'multiple definitions' do
      response = YandexMystem::Raw.stem('девочка мальчиков пошла к комьютерам искать, в прочем, как и всегда')

      expect(response.size).to eq 11

      analysis = response.find { |h| h[:text] == 'девочка' }[:analysis].first

      expect(analysis[:lex]).to eq 'девочка'
      expect(analysis[:wt]).to eq 1
      expect(analysis[:gr]).to eq 'S,f,anim=nom,sg'

      expect(response.find { |h| h[:text] == 'мальчиков'}[:analysis].size).to eq 3
    end

    it 'get geo name' do
      response = YandexMystem::Raw.stem('Москва')
      expect(response.find { |h| h[:text] == 'Москва' }[:analysis].first[:gr]).to include 'geo'
    end
  end
end
