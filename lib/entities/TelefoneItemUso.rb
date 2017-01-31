require 'entities/Ligacao'
require 'entities/Totalizador'
require 'entities/ReferenciaItem'
require 'entities/Consumo'

class TelefoneItemUso
  attr_accessor :ligacoes, :sms, :internet, :outros, :total_computado

  def initialize
    @total_computado = Totalizador.new
    @ligacoes = Ligacao.new
    @sms = Consumo.new
    @internet = Consumo.new
    @outros = Consumo.new
  end

  def setUso(columns, map)
    case columns[map[:tpserv]]
      when /locais|longa/i
        @ligacoes.setLigacao(columns, map)

      when /torpedo|sms|mensagem/i
        @sms.setConsumo(columns, map)

      when /wap|connect|blackberry/i
        @internet.setConsumo(columns, map)

      when /portal de voz|vas|sons|jogos|rádios|roaming|tarifa zero|auxílio à lista|100/i
        @outros.setConsumo(columns, map)

    end
  end

  def getValorUsoTelefone
    @ligacoes.total_computado.valor_total +
    @sms.total_computado.valor_total +
    @internet.total_computado.valor_total +
    @outros.total_computado.valor_total
  end

  def getUnidadeUsoTelefone
    @ligacoes.total_computado.unidade_total +
    @sms.total_computado.unidade_total +
    @internet.total_computado.unidade_total +
    @outros.total_computado.unidade_total
  end

  def getQuantidadeRegistrosUsoTelefone
    @ligacoes.total_computado.quantidade_registros +
    @sms.total_computado.quantidade_registros +
    @internet.total_computado.quantidade_registros +
    @outros.total_computado.quantidade_registros
  end
end
