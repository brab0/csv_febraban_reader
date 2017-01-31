require 'csv'
require "entities/Fatura"
require "config_index_reader"
require "outputs"

module CsvFebrabanReader

  @fatura = Fatura.new

  def self.read(file, map, &cb)
    CSV.foreach(file) do |row|
      if row.kind_of?(Array) then
        strRow = row.join(",")
      end

      load(strRow.split(/;/), map)
    end

    yield(@fatura) if cb
  end

  def self.load(columns, map)
    @fatura.setTelefone(columns, map)
    @fatura.setIfRefereciaFinal(columns, map)
  end

  def self.detalhes(file)
    read(file, ConfigIndexReader::V1) do |fatura|
      itemUso = getSumItens(fatura.telefone.itens)

      Output.renderDetalhes(fatura, itemUso)
    end
  end

  def self.detalhesByPhone(file, numero)
    read(file, ConfigIndexReader::V1) do |fatura|
      index = fatura.telefone.itens.index{ |telefone| telefone.numero ==  numero}
      item = fatura.telefone.itens[index]

      Output.renderDetalhesByPhone(fatura, item)
    end

  end

  def self.getSumItens(itens)
    itemUso = TelefoneItemUso.new
    ligacoes = Ligacao.new
    sms = Consumo.new
    internet = Consumo.new
    outros = Consumo.new

    itens.each do |item|
      itemUso.ligacoes = sumLigacoes(ligacoes, item.uso.ligacoes)
      itemUso.sms = sumConsumos(sms, item.uso.sms)
      itemUso.internet = sumConsumos(internet, item.uso.internet)
      itemUso.outros = sumConsumos(outros, item.uso.outros)
    end

    itemUso
  end

  def self.sumConsumos(consumo, item)
    consumo.total_computado.sumUnidadeTotal(item.total_computado.unidade_total)
    consumo.total_computado.sumValorTotal(item.total_computado.valor_total)
    consumo.total_computado.sumQuantidadeRegistrosTotal(item.total_computado.quantidade_registros)

    consumo
  end

  def self.sumLigacoes(ligacao, item)
    sumConsumos(ligacao, item)
    sumConsumos(ligacao.local, item.local)
    sumConsumos(ligacao.local.celular, item.local.celular)
    sumConsumos(ligacao.local.fixo, item.local.fixo)
    sumConsumos(ligacao.longa_distancia, item.longa_distancia)
    sumConsumos(ligacao.longa_distancia.celular, item.longa_distancia.celular)
    sumConsumos(ligacao.longa_distancia.fixo, item.longa_distancia.fixo)

    ligacao
  end
end
