module Output

  def self.renderDetalhes(fatura, uso)
     puts "-----------------------------------"
     puts "         Resumo da Fatura          "
     puts "-----------------------------------"

     renderSms(uso.sms)

     renderInternet(uso.internet)

     renderOutros(uso.outros)

     renderLigacoes(uso.ligacoes)

     puts "------------------------------------------------------"
     puts " Valor Total da Fatura: " +  fatura.getValorTotal.to_s
     puts " Quantidade Total de Telefones: " +  fatura.telefone.itens.length.to_s
     puts " Quantidade Total de Registros: " +  fatura.getQuantidadeTotalRegistros.to_s
     puts "------------------------------------------------------"
     puts ""
  end

  def self.renderDetalhesByPhone(fatura, item)

      puts "-----------------------------------------"
      puts "         Telefone: " +  item.numero
      puts "-----------------------------------------"

      renderSms(item.uso.sms)

      renderInternet(item.uso.internet)

      renderOutros(item.uso.outros)

      renderLigacoes(item.uso.ligacoes)

      puts "------------------------------------------------------"
      puts " Quantidade Total de Registros do Telefone: " +  item.uso.getQuantidadeRegistrosUsoTelefone.to_s
      puts " Valor Total Computado de Uso do Telefone: " +  item.uso.getValorUsoTelefone.round(2).to_s
      puts " Valor Total Assinaturas do Telefone: " +  item.assinatura.total_computado.valor_total.round(2).to_s
      puts " Valor Total Créditos do Telefone: " +  item.creditos.total_computado.valor_total.round(2).to_s
      puts " Referência do Total de Uso do Telefone: " +  item.referencia.total_uso.to_s
      puts " Referência do Total de Assinaturas do Telefone: " +  item.referencia.total_assinatura.to_s
      puts " Referência do Total de Créditos do Telefone: " +  item.referencia.total_credito.to_s
      puts "------------------------------------------------------"
      puts " Valor Total Computado da Fatura: " +  fatura.getValorTotal.to_s
      puts " Valor Total da Referência Coletada: " +  fatura.total_referencia.to_s
      puts " Quantidade Total de Telefones: " +  fatura.telefone.itens.length.to_s
      puts " Quantidade Total de Registros: " +  fatura.getQuantidadeTotalRegistros.to_s
      puts "------------------------------------------------------"
      puts ""
  end

  def self.renderSms(sms)
    puts "| Sms:"
    puts "|--| Quantidade Total: " +  sms.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  sms.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  sms.total_computado.quantidade_registros.to_s
  end

  def self.renderInternet(internet)
    puts "| Internet:"
    puts "|--| Quantidade Total(Bytes): " +  internet.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  internet.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  internet.total_computado.quantidade_registros.to_s
  end

  def self.renderOutros(outros)
    puts "| Outros:"
    puts "|--| Quantidade Total: " +  outros.total_computado.unidade_total.to_s
    puts "|--| Valor Total: " +  outros.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  outros.total_computado.quantidade_registros.to_s
  end

  def self.renderLigacoes(ligacoes)
    puts "| Ligações:"
    puts "|--| Duração Total: " +  Time.at(ligacoes.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--| Valor Total: " +  ligacoes.total_computado.valor_total.to_s
    puts "|--| Total de Registros: " +  ligacoes.total_computado.quantidade_registros.to_s
    puts "|--| Locais:"
    puts "|--|--| Duração Total: " +  Time.at(ligacoes.local.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--| Valor Total: " +  ligacoes.local.total_computado.valor_total.to_s
    puts "|--|--| Total de Registros: " +  ligacoes.local.total_computado.quantidade_registros.to_s
    puts "|--|--| Celular:"
    puts "|--|--|--| Duração Total: " +  Time.at(ligacoes.local.celular.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  ligacoes.local.celular.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  ligacoes.local.celular.total_computado.quantidade_registros.to_s

    renderServ(ligacoes.local.celular.consumo_tipos)

    puts "|--|--| Fixo:"
    puts "|--|--|--| Duração Total: " +  Time.at(ligacoes.local.fixo.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  ligacoes.local.fixo.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  ligacoes.local.fixo.total_computado.quantidade_registros.to_s

    renderServ(ligacoes.local.fixo.consumo_tipos)

    puts "|--| Longa Distância:"
    puts "|--|--| Duração Total: " +  Time.at(ligacoes.longa_distancia.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--| Valor Total: " +  ligacoes.longa_distancia.total_computado.valor_total.to_s
    puts "|--|--| Total de Registros: " +  ligacoes.longa_distancia.total_computado.quantidade_registros.to_s
    puts "|--|--| Celular:"
    puts "|--|--|--| Duração Total: " +  Time.at(ligacoes.longa_distancia.celular.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  ligacoes.longa_distancia.celular.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  ligacoes.longa_distancia.celular.total_computado.quantidade_registros.to_s

    renderServ(ligacoes.longa_distancia.celular.consumo_tipos)

    puts "|--|--| Fixo:"
    puts "|--|--|--| Duração Total: " +  Time.at(ligacoes.longa_distancia.fixo.total_computado.unidade_total).utc.strftime("%H:%M:%S")
    puts "|--|--|--| Valor Total: " +  ligacoes.longa_distancia.fixo.total_computado.valor_total.to_s
    puts "|--|--|--| Total de Registros: " +  ligacoes.longa_distancia.fixo.total_computado.quantidade_registros.to_s

    renderServ(ligacoes.longa_distancia.fixo.consumo_tipos)
  end

  def self.renderServ(consumoTipos)
    if consumoTipos.length > 0 then
      puts "|--|--|--| Tipos de Serviço: "

      consumoTipos.each do |serv|
        puts "|--|--|--|--| Descrição: " + serv.descricao
        puts "|--|--|--|--|--| Duração Total: " + Time.at(serv.total_computado.unidade_total).utc.strftime("%H:%M:%S")
        puts "|--|--|--|--|--| Valor Total: " + serv.total_computado.valor_total.to_s
        puts "|--|--|--|--|--| Total de Registros: " + serv.total_computado.quantidade_registros.to_s
      end
    end
  end
end
