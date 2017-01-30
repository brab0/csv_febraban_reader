require 'entities/ConsumoTipo'
require 'entities/Totalizador'

class Consumo
  attr_reader :consumo_tipos, :total_computado

  def initialize
    @total_computado = Totalizador.new
    @consumo_tipos = []
  end

  def setConsumo(columns, map)

    index = @consumo_tipos.find_index{ |tipo| tipo.descricao ==  columns[map[:tpserv]]}

    item = ConsumoTipo.new

    item.total_computado.sumQuantidadeRegistrosTotal(1)

    item.descricao = columns[map[:tpserv]]

    item.setValorTotal(columns[map[:valor]])
    item.setUnidadeTotal(columns[map[:unidade]])

    if index then
      @consumo_tipos[index].total_computado.sumQuantidadeRegistrosTotal(item.total_computado.quantidade_registros)
      @consumo_tipos[index].total_computado.sumValorTotal(item.total_computado.valor_total)
      @consumo_tipos[index].total_computado.sumUnidadeTotal(item.total_computado.unidade_total)
    else
      @consumo_tipos.push(item)
    end

    @total_computado.sumValorTotal(item.total_computado.valor_total)
    @total_computado.sumQuantidadeRegistrosTotal(item.total_computado.quantidade_registros)
    @total_computado.sumUnidadeTotal(item.total_computado.unidade_total)
  end
end
