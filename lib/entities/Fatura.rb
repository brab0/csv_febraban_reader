require 'entities/Telefone'

class Fatura
  attr_reader :telefone, :total_referencia

  def initialize
    @telefone = Telefone.new
    @total_referencia = 0.0
    # @plano = 0,
    # @credito = 0
  end

  def getValorTotal
    @telefone.total_computado.valor_total
    # @plano +
    # @credito
  end

  def getQuantidadeTotalRegistros
    @telefone.total_computado.quantidade_registros
    # @plano +
    # @credito
  end

  def setTelefone(columns, map)
    @telefone.setItens(columns, map)
  end

  def setIfRefereciaFinal(columns, map)
    if columns[map[:tpserv]].match(/total fatura/i) then
      @total_referencia = columns[map[:valor]].gsub(",",".").to_f
    end
  end
end
