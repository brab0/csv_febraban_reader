require 'entities/Ligacao'
require 'entities/Totalizador'
require 'entities/ReferenciaItem'
require 'entities/Consumo'
require 'entities/TelefoneItemUso'

class TelefoneItem
  attr_accessor :numero
  attr_reader :ligacoes, :sms, :internet, :outros, :assinatura, :total_computado, :referencia, :uso, :creditos

  def initialize
    @numero = ""
    @referencia = ReferenciaItem.new
    @uso = TelefoneItemUso.new
    @assinatura = Consumo.new
    @mensalidade = Consumo.new
    @creditos = Consumo.new
    @descontos = Consumo.new
  end

  def setFields(columns, map)
    if columns[map[:data]].match(/[0-9]{2}\/[0-9]{2}\/[0-9]{2}/)
      @uso.setUso(columns, map)
    else
      case columns[map[:tpserv]]
        when /rádios|tarifa zero/i
          @mensalidade.setConsumo(columns, map)

        when /total de uso/i
          @referencia.total_uso = columns[map[:valor]].gsub(",",".").to_f

        when /total de assinatura/i
          @referencia.total_assinatura = columns[map[:valor]].gsub(",",".").to_f
          @assinatura.setConsumo(columns, map)

        when /total outros/i
          @referencia.total_credito = columns[map[:valor]].gsub(",",".").to_f
          @creditos.setConsumo(columns, map)

        when /pct. 100 minutos|tarifa zero/i
          @referencia.sumTotalDescontos(columns[map[:valor]].gsub(",",".").to_f)
          @descontos.setConsumo(columns, map)

      end
    end
  end

  def getValorTotalTelefone
    @uso.getValorUsoTelefone +
    @assinatura.total_computado.valor_total +
    @creditos.total_computado.valor_total +
    @mensalidade.total_computado.valor_total +
    @descontos.total_computado.valor_total
  end

  def getUnidadeTotalTelefone
    @uso.getUnidadeUsoTelefone
  end

  def getQuantidadeRegistrosTotalTelefone
    @uso.getUnidadeUsoTelefone
  end

  def setNumero(columns, map)
    @numero = columns[map[:numAcs]]
  end

  def isValid(columns, map)
    columns[map[:numAcs]].match(/^([0-9]{3}-[0-9]{4}-[0-9]{4})|([0-9]{3}-[0-9]{5}-[0-9]{4})$/)
  end

  def isNew(last, columns, map)
    current = columns[map[:numAcs]]
    last != current ? true : false
  end
end
