# CsvFebrabanReader
Leitor de Faturas Csv Febraban

## Installation

    $ bundle

Or install it yourself as:

    $ gem install csv_febraban_reader

## Usage
###Teste

    $ rake

###Outputs

    $ CsvFebrabanReader.detalhes('/path/to/file')
    
    $ CsvFebrabanReader.detalhesByPhone('/path/to/file', "xx-xxxx-xxxx')
    
## TODO

- Ainda quero fechar o processamento com a referencia do valor total da fatura
- rodar com: CsvFebrabanReader sample.txt 048-8802-2245
