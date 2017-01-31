require 'entities/Totalizador'

class ConsumoTipo

  attr_reader :total_computado
  attr_accessor :descricao, :medida

  def initialize
    @descricao = ""
    @total_computado = Totalizador.new
    @medida = ""
  end

  def setUnidadeTotal(unidade)
    @total_computado.unidade_total = formatUnidade(unidade)
  end

  def setValorTotal(valor)
    valorStr = valor == nil || valor == "" ? "0.0" : valor.tr(',', '.')

    @total_computado.valor_total = valorStr.to_f
  end

  def formatUnidade(unidade)
    formattedUnidade = 0

    if unidade.match(/b|kb|mb/i) then
      @medida = "bytes"

      unidade = unidade.gsub(/\s+b/i,"").tr(",",".")

      if unidade.match(/\s+b/i) then
        formattedUnidade = unidade.to_i

      elsif unidade.match(/kb/i) then
        formattedUnidade = unidade.to_i * 1024

      elsif unidade.match(/mb/i) then
        formattedUnidade = (unidade.to_i * 1024)*1024
      end

    elsif unidade.match(/[hms]/) then
      @medida = "duracao"

      str = "00:" + unidade.split(/[hms]/).join(":")

      formattedUnidade = (DateTime.parse(str).to_time).to_i

    else
      @medida = "quantidade"

      formattedUnidade = unidade == "" ? 1 : unidade.to_i

    end

    formattedUnidade
  end
end
