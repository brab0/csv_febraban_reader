require 'entities/TelefoneItem'
require 'entities/Totalizador'

class Telefone

  attr_reader :itens, :total_computado

  def initialize
    @total_computado = Totalizador.new
    @itens = []
  end

  def setItens(columns, map)
    item = TelefoneItem.new
    last = 0

    if item.isValid(columns, map) then
      if @itens.length > 0 then
        last = @itens[@itens.length - 1].numero
      end

      item.setFields(columns, map)

      if item.isNew(last, columns, map) then
        item.setNumero(columns, map)
        @itens.push(item)

      else
        @itens[@itens.length - 1].setFields(columns, map)
      end

      @total_computado.sumQuantidadeRegistrosTotal(1)      
      @total_computado.sumValorTotal(item.getValorTotalTelefone)
      @total_computado.sumUnidadeTotal(item.getUnidadeTotalTelefone)

    end
  end
end
