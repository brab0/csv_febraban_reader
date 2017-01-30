class Totalizador
  attr_accessor :valor_total, :unidade_total, :quantidade_registros

  def initialize
    @valor_total = 0.0
    @unidade_total = 0
    @quantidade_registros = 0    
  end

  def sumValorTotal(valor)
    @valor_total += valor
  end

  def sumUnidadeTotal(unidade)
    @unidade_total += unidade
  end

  def sumQuantidadeRegistrosTotal(qtd)
    @quantidade_registros += qtd
  end
end
