# CsvFebrabanReader
Leitor de Faturas Csv Febraban

## Installation

    $ bundle

Ou:

    $ gem install csv_febraban_reader

## Usage
###Teste

    $ rake

###Run
```html
$ irb
$ require './lib/csv_febraban_reader.rb'
$ CsvFebrabanReader.detalhes './lib/sample-files/tim/sample-tim.csv'
$ CsvFebrabanReader.detalhesByPhone('./lib/sample-files/tim/sample-tim.csv', 'xxx-xxxx-xxxx'
```
