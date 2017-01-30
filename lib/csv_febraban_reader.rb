require 'csv'
require "entities/Fatura"
require "config_index_reader"

module CsvFebrabanReader

  @fatura = Fatura.new

  def self.read(file, map, &block)

    CSV.foreach(file) do |row|

      if row.kind_of?(Array) then
        strRow = row.join(",")
      end

      load(strRow.split(/;/), map)

    end

    yield(@fatura)

  end

  def self.load(columns, map)
    @fatura.setTelefone(columns, map)
    @fatura.setIfRefereciaFinal(columns, map)
  end

  def self.detalhes(file)
    CsvFebrabanReader.read(file, ConfigIndexReader::V1) do |fatura|
      telefones = TelefoneItem.new

      fatura.telefone.itens.each do |item|
        telefones.uso.ligacoes.total_computado.sumUnidadeTotal(item.uso.ligacoes.total_computado.unidade_total)
        telefones.uso.ligacoes.total_computado.sumValorTotal(item.uso.ligacoes.total_computado.valor_total)
        telefones.uso.ligacoes.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.total_computado.quantidade_registros)

        telefones.uso.ligacoes.local.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.total_computado.unidade_total)
        telefones.uso.ligacoes.local.total_computado.sumValorTotal(item.uso.ligacoes.local.total_computado.valor_total)
        telefones.uso.ligacoes.local.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.total_computado.quantidade_registros)

        telefones.uso.ligacoes.local.celular.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.celular.total_computado.unidade_total)
        telefones.uso.ligacoes.local.celular.total_computado.sumValorTotal(item.uso.ligacoes.local.celular.total_computado.valor_total)
        telefones.uso.ligacoes.local.celular.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.celular.total_computado.quantidade_registros)

        telefones.uso.ligacoes.local.fixo.total_computado.sumUnidadeTotal(item.uso.ligacoes.local.fixo.total_computado.unidade_total)
        telefones.uso.ligacoes.local.fixo.total_computado.sumValorTotal(item.uso.ligacoes.local.fixo.total_computado.valor_total)
        telefones.uso.ligacoes.local.fixo.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.local.fixo.total_computado.quantidade_registros)

        telefones.uso.ligacoes.longa_distancia.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.total_computado.unidade_total)
        telefones.uso.ligacoes.longa_distancia.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.total_computado.valor_total)
        telefones.uso.ligacoes.longa_distancia.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.total_computado.quantidade_registros)

        telefones.uso.ligacoes.longa_distancia.celular.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.unidade_total)
        telefones.uso.ligacoes.longa_distancia.celular.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.valor_total)
        telefones.uso.ligacoes.longa_distancia.celular.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.celular.total_computado.quantidade_registros)

        telefones.uso.ligacoes.longa_distancia.fixo.total_computado.sumUnidadeTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.unidade_total)
        telefones.uso.ligacoes.longa_distancia.fixo.total_computado.sumValorTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.valor_total)
        telefones.uso.ligacoes.longa_distancia.fixo.total_computado.sumQuantidadeRegistrosTotal(item.uso.ligacoes.longa_distancia.fixo.total_computado.quantidade_registros)

        telefones.uso.sms.total_computado.sumUnidadeTotal(item.uso.sms.total_computado.unidade_total)
        telefones.uso.sms.total_computado.sumValorTotal(item.uso.sms.total_computado.valor_total)
        telefones.uso.sms.total_computado.sumQuantidadeRegistrosTotal(item.uso.sms.total_computado.quantidade_registros)

        telefones.uso.internet.total_computado.sumUnidadeTotal(item.uso.internet.total_computado.unidade_total)
        telefones.uso.internet.total_computado.sumValorTotal(item.uso.internet.total_computado.valor_total)
        telefones.uso.internet.total_computado.sumQuantidadeRegistrosTotal(item.uso.internet.total_computado.quantidade_registros)

        telefones.uso.outros.total_computado.sumUnidadeTotal(item.uso.outros.total_computado.unidade_total)
        telefones.uso.outros.total_computado.sumValorTotal(item.uso.outros.total_computado.valor_total)
        telefones.uso.outros.total_computado.sumQuantidadeRegistrosTotal(item.uso.outros.total_computado.quantidade_registros)
      end

      # quantidade_total_registros = ligacoes.total_computado.quantidade_registros +
      #                        sms.total_computado.quantidade_registros +
      #                        internet.total_computado.quantidade_registros +
      #                        outros.total_computado.quantidade_registros +
      #                        assinatura.total_computado.quantidade_registros

       puts "-----------------------------------"
       puts "         Resumo da Fatura          "
       puts "-----------------------------------"

       renderBody(telefones)

       puts "------------------------------------------------------"
       puts " Valor Total da Fatura: " +  fatura.getValorTotal.to_s
       puts " Quantidade Total de Telefones: " +  fatura.telefone.itens.length.to_s
       puts " Quantidade Total de Registros: " +  fatura.getQuantidadeTotalRegistros.to_s
       puts "------------------------------------------------------"
       puts ""
    end
  end

  def self.detalhesByPhone(file, numero)

    # o ConfigIndexReader::V1 passado como parâmetro tornaria
    # o método mais modular e desacoplado
    CsvFebrabanReader.read(file, ConfigIndexReader::V1) do |fatura|
      index = fatura.telefone.itens.index{ |telefone| telefone.numero ==  numero}

      item = fatura.telefone.itens[index]

      puts "-----------------------------------------"
      puts "         Telefone: " +  numero
      puts "-----------------------------------------"

      renderBody(item)

      puts "------------------------------------------------------"
      puts " Quantidade Total de Registros do Telefone: " +  fatura.telefone.itens[index].uso.getQuantidadeRegistrosUsoTelefone.to_s
      puts " Valor Total Computado de Uso do Telefone: " +  fatura.telefone.itens[index].uso.getValorUsoTelefone.round(2).to_s
      puts " Valor Total Assinaturas do Telefone: " +  fatura.telefone.itens[index].assinatura.total_computado.valor_total.round(2).to_s
      puts " Valor Total Créditos do Telefone: " +  fatura.telefone.itens[index].creditos.total_computado.valor_total.round(2).to_s
      puts " Referência do Total de Uso do Telefone: " +  fatura.telefone.itens[index].referencia.total_uso.to_s
      puts " Referência do Total de Assinaturas do Telefone: " +  fatura.telefone.itens[index].referencia.total_assinatura.to_s
      puts " Referência do Total de Créditos do Telefone: " +  fatura.telefone.itens[index].referencia.total_credito.to_s
      puts "------------------------------------------------------"
      puts " Valor Total Computado da Fatura: " +  fatura.getValorTotal.to_s
      puts " Valor Total da Referência Coletada: " +  fatura.total_referencia.to_s
      puts " Quantidade Total de Telefones: " +  fatura.telefone.itens.length.to_s
      puts " Quantidade Total de Registros: " +  fatura.getQuantidadeTotalRegistros.to_s
      puts "------------------------------------------------------"
      puts ""
    end
  end

  def self.renderBody(item)
    puts "| Sms:"
    puts "|--| Quantidade Total: " +  item.uso.sms.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  item.uso.sms.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  item.uso.sms.total_computado.quantidade_registros.to_s
    puts "| Internet:"
    puts "|--| Quantidade Total(Bytes): " +  item.uso.internet.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  item.uso.internet.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  item.uso.internet.total_computado.quantidade_registros.to_s
    puts "| Outros:"
    puts "|--| Quantidade Total: " +  item.uso.outros.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  item.uso.outros.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  item.uso.outros.total_computado.quantidade_registros.to_s
    puts "| Ligações:"
    puts "|--| Duração Total: " +  Time.at(item.uso.ligacoes.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--| Valor Total: " +  item.uso.ligacoes.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  item.uso.ligacoes.total_computado.quantidade_registros.to_s
    puts "|--| Locais:"
    puts "|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.local.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--| Valor Total: " +  item.uso.ligacoes.local.total_computado.valor_total.to_s
    puts "|--|--| Total de Registros: " +  item.uso.ligacoes.local.total_computado.quantidade_registros.to_s
    puts "|--|--| Celular:"
    puts "|--|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.local.celular.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  item.uso.ligacoes.local.celular.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  item.uso.ligacoes.local.celular.total_computado.quantidade_registros.to_s

    if item.uso.ligacoes.local.celular.consumo_tipos.length > 0 then
      puts "|--|--|--| Tipos de Serviço: "

      item.uso.ligacoes.local.celular.consumo_tipos.each do |serv|
        puts "|--|--|--|--| Descrição: " + serv.descricao
        puts "|--|--|--|--|--| Duração Total: " + Time.at(serv.total_computado.unidade_total).utc.strftime("%H:%M:%S")
        puts "|--|--|--|--|--| Valor Total: " + serv.total_computado.valor_total.to_s
        puts "|--|--|--|--|--| Total de Registros: " + serv.total_computado.quantidade_registros.to_s
      end
    end

    puts "|--|--| Fixo:"
    puts "|--|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.local.fixo.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  item.uso.ligacoes.local.fixo.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  item.uso.ligacoes.local.fixo.total_computado.quantidade_registros.to_s

    if item.uso.ligacoes.local.fixo.consumo_tipos.length > 0 then
      puts "|--|--|--| Tipos de Serviço: "

      item.uso.ligacoes.local.fixo.consumo_tipos.each do |serv|
        puts "|--|--|--|--| Descrição: " + serv.descricao
        puts "|--|--|--|--|--| Duração Total: " + Time.at(serv.total_computado.unidade_total).utc.strftime("%H:%M:%S")
        puts "|--|--|--|--|--| Valor Total: " + serv.total_computado.valor_total.to_s
        puts "|--|--|--|--|--| Total de Registros: " + serv.total_computado.quantidade_registros.to_s
      end
    end

    puts "|--| Longa Distância:"
    puts "|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.longa_distancia.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--| Valor Total: " +  item.uso.ligacoes.longa_distancia.total_computado.valor_total.to_s
    puts "|--|--| Total de Registros: " +  item.uso.ligacoes.longa_distancia.total_computado.quantidade_registros.to_s
    puts "|--|--| Celular:"
    puts "|--|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.longa_distancia.celular.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  item.uso.ligacoes.longa_distancia.celular.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  item.uso.ligacoes.longa_distancia.celular.total_computado.quantidade_registros.to_s

    if item.uso.ligacoes.longa_distancia.celular.consumo_tipos.length > 0 then
      puts "|--|--|--| Tipos de Serviço: "

      item.uso.ligacoes.longa_distancia.celular.consumo_tipos.each do |serv|
        puts "|--|--|--|--| Descrição: " + serv.descricao
        puts "|--|--|--|--|--| Duração Total: " + Time.at(serv.total_computado.unidade_total).utc.strftime("%H:%M:%S")
        puts "|--|--|--|--|--| Valor Total: " + serv.total_computado.valor_total.to_s
        puts "|--|--|--|--|--| Total de Registros: " + serv.total_computado.quantidade_registros.to_s
      end
    end

    puts "|--|--| Fixo:"
    puts "|--|--|--| Duração Total: " +  Time.at(item.uso.ligacoes.longa_distancia.fixo.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  item.uso.ligacoes.longa_distancia.fixo.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  item.uso.ligacoes.longa_distancia.fixo.total_computado.quantidade_registros.to_s

    if item.uso.ligacoes.longa_distancia.fixo.consumo_tipos.length > 0 then
      puts "|--|--|--| Tipos de Serviço: "

      item.uso.ligacoes.longa_distancia.fixo.consumo_tipos.each do |serv|
        puts "|--|--|--|--| Descrição: " + serv.descricao
        puts "|--|--|--|--|--| Duração Total: " + Time.at(serv.total_computado.unidade_total).utc.strftime("%H:%M:%S")
        puts "|--|--|--|--|--| Valor Total: " + serv.total_computado.valor_total.to_s
        puts "|--|--|--|--|--| Total de Registros: " + serv.total_computado.quantidade_registros.to_s
      end
    end
  end
end
