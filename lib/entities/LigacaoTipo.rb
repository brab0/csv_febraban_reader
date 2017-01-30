require 'entities/Consumo'
require 'entities/Totalizador'

class LigacaoTipo
  attr_reader :celular, :fixo, :total_computado

  def initialize
    @celular = Consumo.new
    @fixo = Consumo.new
    @total_computado = Totalizador.new
  end

  def setLigacaoTipo(columns, map)
    if columns[map[:tpserv]].match(/fixo/i) then
      @fixo.setConsumo(columns, map)
    else
      @celular.setConsumo(columns, map)
    end

    @total_computado.valor_total = @fixo.total_computado.valor_total + @celular.total_computado.valor_total
    @total_computado.unidade_total = @fixo.total_computado.unidade_total + @celular.total_computado.unidade_total
    @total_computado.quantidade_registros = @fixo.total_computado.quantidade_registros + @celular.total_computado.quantidade_registros
  end
end
