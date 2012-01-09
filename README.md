# Yandex Mystem

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

    YandexMystem::Base.stem 'О предложении в котором много слов.'