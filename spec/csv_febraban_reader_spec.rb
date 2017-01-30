require 'spec_helper'

describe CsvFebrabanReader do

  it 'should has a version number' do
    expect(CsvFebrabanReader::VERSION).not_to be nil
  end

  it 'should match all telephones with their references' do
    file = "lib/sample-files/tim/febraban.csv"

    #CsvFebrabanReader.detalhes(file)
    #CsvFebrabanReader.detalhesByPhone(file, "048-8802-2245")

    CsvFebrabanReader.read(file, ConfigIndexReader::V1){ |fatura|
      fatura.telefone.itens.each_with_index do |telefone, index|
        expect(telefone.uso.getValorUsoTelefone.round(2)).to eq(telefone.referencia.total_uso.round(2))
      end
    }
  end
end
