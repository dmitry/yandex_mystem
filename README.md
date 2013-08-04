# Yandex Mystem

[![Build Status](https://secure.travis-ci.org/dmitry/yandex_mystem.png?branch=master)](http://travis-ci.org/dmitry/yandex_mystem) [![Gem Version](https://badge.fury.io/rb/yandex_mystem.png)](http://badge.fury.io/rb/yandex_mystem) [![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dmitry/yandex_mystem/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


## Introduction

Mystem is a software that provided by the Yandex only for non-commercial project. With use of it you can detect base forms of the words in a text, make a simple morphological analysis of russian words.

## Installation

    gem install yandex_mystem

## License

First of all, read license on http://company.yandex.ru/technologies/mystem/

`Mystem` available only for non-commercial usage.

## OS

This gem contains executables for there platforms:

* Windows
* Linux 2.6 32-bit
* Linux 2.6 64-bit
* Mac OS X 10.5

...of six, FreeBSD not in the gem. If you need it, add pull request or issue.

## Usage

    YandexMystem::Simple.stem 'О предложении в котором много слов.'
    YandexMystem::Extended.stem 'нет сов'
