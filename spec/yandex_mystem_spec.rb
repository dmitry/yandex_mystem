# encoding: utf-8
require 'spec_helper'

describe YandexMystem do
  it "should stem words" do
    data = YandexMystem::Base.stem('мальчики мальчиков девочки девочек компьютеров компьютере сов пошли elements')
    data['мальчики'].should eq ['мальчик']
    data['мальчиков'].should eq ['мальчик', "мальчиков", "мальчиковый"]
    data['девочки'].should eq ['девочка']
    data['девочек'].should eq ['девочка']
    data['сов'].should eq ['сова']
    data['пошли'].should eq %w(пойти посылать)
    data['elements'].should eq []
  end
end