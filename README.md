# Yandex Mystem

[![Build Status](https://secure.travis-ci.org/dmitry/yandex_mystem.png?branch=master)](http://travis-ci.org/dmitry/yandex_mystem) [![Gem Version](https://badge.fury.io/rb/yandex_mystem.png)](http://badge.fury.io/rb/yandex_mystem) [![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dmitry/yandex_mystem/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


## Version 3.0 not compatible with previous

Mystem 3.0 support JSON format, so we should use this option.
This gem (yandex_mystem) now returns information in JSON-like ruby native format (array of hashes).
More info about Mystem changes: http://api.yandex.ru/mystem/downloads/

## Introduction

Mystem is a software that provided by the Yandex only for non-commercial project. With use of it you can detect base forms of the words in a text, make a simple morphological analysis of russian words.

## Installation

    gem install yandex_mystem

Current version is **3.0.1**

## License

First of all, read license on http://api.yandex.ru/mystem/

`Mystem` available only for non-commercial usage.

## OS

This gem contains executables for there platforms:

* Windows 7 32-bit
* Linux 3.5 32-bit
* Linux 3.1 64-bit
* Freebsd 9.0 64-bit
* Mac OS X

## Usage

    YandexMystem::Simple.stem 'О предложении в котором много слов.'
    YandexMystem::Raw.stem 'нет сов'
