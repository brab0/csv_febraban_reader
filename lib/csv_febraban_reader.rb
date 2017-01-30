require 'csv'
require "entities/Fatura"
require "config_index_reader"
require "outputs"

module CsvFebrabanReader

  @fatura = Fatura.new

  def self.read(file, map, &block)

    CSV.foreach(file) do |row|

      if row.kind_of?(Array) then
        strRow = row.join(",")
      end

      load(strRow.split(/;/), map)

    end

    yield(@fatura)

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

    itens.each do |item|
      itemUso.ligacoes.total_computado.sumUnidadeTotal(item.uso.ligacoes.total_computado.unidade_total)
      itemUso.ligacoes.total_computado.sumValorTotal(item.uso.ligacoes.total_computado.valor_total)
      itemUso.ligacoes.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.total_computado.quantidade_registros)

      itemUso.ligacoes.local.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.total_computado.unidade_total)
      itemUso.ligacoes.local.total_computado.sumValorTotal(item.uso.ligacoes.local.total_computado.valor_total)
      itemUso.ligacoes.local.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.total_computado.quantidade_registros)

      itemUso.ligacoes.local.celular.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.celular.total_computado.unidade_total)
      itemUso.ligacoes.local.celular.total_computado.sumValorTotal(item.uso.ligacoes.local.celular.total_computado.valor_total)
      itemUso.ligacoes.local.celular.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.celular.total_computado.quantidade_registros)

      itemUso.ligacoes.local.fixo.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.fixo.total_computado.unidade_total)
      itemUso.ligacoes.local.fixo.total_computado.sumValorTotal(item.uso.ligacoes.local.fixo.total_computado.valor_total)
      itemUso.ligacoes.local.fixo.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.fixo.total_computado.quantidade_registros)

      itemUso.ligacoes.longa_distancia.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.total_computado.unidade_total)
      itemUso.ligacoes.longa_distancia.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.total_computado.valor_total)
      itemUso.ligacoes.longa_distancia.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.total_computado.quantidade_registros)

      itemUso.ligacoes.longa_distancia.celular.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.unidade_total)
      itemUso.ligacoes.longa_distancia.celular.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.valor_total)
      itemUso.ligacoes.longa_distancia.celular.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.quantidade_registros)

      itemUso.ligacoes.longa_distancia.fixo.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.unidade_total)
      itemUso.ligacoes.longa_distancia.fixo.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.valor_total)
      itemUso.ligacoes.longa_distancia.fixo.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.quantidade_registros)

      itemUso.sms.total_computado.sumUnidadeTotal(item.uso.sms.total_computado.unidade_total)
      itemUso.sms.total_computado.sumValorTotal(item.uso.sms.total_computado.valor_total)
      itemUso.sms.total_computado.sumQuantidadeRegistrosTotal(item.uso.sms.total_computado.quantidade_registros)

      itemUso.internet.total_computado.sumUnidadeTotal(item.uso.internet.total_computado.unidade_total)
      itemUso.internet.total_computado.sumValorTotal(item.uso.internet.total_computado.valor_total)
      itemUso.internet.total_computado.sumQuantidadeRegistrosTotal(item.uso.internet.total_computado.quantidade_registros)

      itemUso.outros.total_computado.sumUnidadeTotal(item.uso.outros.total_computado.unidade_total)
      itemUso.outros.total_computado.sumValorTotal(item.uso.outros.total_computado.valor_total)
      itemUso.outros.total_computado.sumQuantidadeRegistrosTotal(item.uso.outros.total_computado.quantidade_registros)
    end

    itemUso

  end
end
