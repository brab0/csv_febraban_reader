class ReferenciaItem
  attr_accessor :total_uso, :total_assinatura, :total_credito, :total_descontos

  def initialize
    @total_uso = 0.0
    @total_assinatura = 0.0
    @total_credito = 0.0
    @total_descontos = 0.0
  end

  def sumTotalDescontos(desconto)
    @total_descontos += desconto
  end  
end
