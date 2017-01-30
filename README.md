# CsvFebrabanReader
Leitor de Faturas Csv Febraban

## Installation

    $ bundle

Or install it yourself as:

    $ gem install csv_febraban_reader

## Usage
###Teste

    $ rake

###Run
    ```html
       $ irb
       $ require './lib/csv_febraban_reader.rb'
       $ CsvFebrabanReader.detalhes './lib/sample-files/tim/sample-tim.csv'
       $ CsvFebrabanReader.detalhesByPhone('./lib/sample-files/tim/sample-tim.csv', '048-8802-2245')
    ´´´
    $ CsvFebrabanReader.detalhes('/path/to/file')
    
    $ CsvFebrabanReader.detalhesByPhone('/path/to/file', "xx-xxxx-xxxx')
    
## TODO

- Ainda quero fechar o processamento com a referencia do valor total da fatura
- CodeClimate
