require 'entities/LigacaoTipo'
require 'entities/Totalizador'

class Ligacao
  attr_reader :local, :longa_distancia, :total_computado

  def initialize
    @local = LigacaoTipo.new
    @longa_distancia = LigacaoTipo.new
    @total_computado = Totalizador.new
  end

  def setLigacao(columns, map)
    if columns[map[:tpserv]].match(/locais/i) then
      @local.setLigacaoTipo(columns, map)

    elsif columns[map[:tpserv]].match(/longa distância/i) then
      @longa_distancia.setLigacaoTipo(columns, map)
    end

    @total_computado.valor_total = @local.total_computado.valor_total + @longa_distancia.total_computado.valor_total
    @total_computado.unidade_total = @local.total_computado.unidade_total + @longa_distancia.total_computado.unidade_total
    @total_computado.quantidade_registros = @local.total_computado.quantidade_registros + @longa_distancia.total_computado.quantidade_registros
  end

end
