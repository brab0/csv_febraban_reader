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
    renderDetail("Sms", 1, sms.total_computado, "quantidade")
  end

  def self.renderInternet(internet)
    renderDetail("Internet", 1, internet.total_computado, "bytes")
  end

  def self.renderOutros(outros)
    renderDetail("Outros", 1, outros.total_computado, "duracao")
  end

  def self.renderLigacoes(ligacoes)
    renderDetail("Ligações", 1, ligacoes.total_computado, "duracao")
    renderDetail("Locais", 2, ligacoes.local.total_computado, "duracao")
    renderDetail("Celular", 3, ligacoes.local.celular.total_computado, "duracao")
    renderServ(ligacoes.local.celular.consumo_tipos)
    renderDetail("Fixo", 3, ligacoes.local.fixo.total_computado, "duracao")
    renderServ(ligacoes.local.fixo.consumo_tipos)
    renderDetail("Longa Distância", 2, ligacoes.longa_distancia.total_computado, "duracao")
    renderDetail("Celular", 3, ligacoes.longa_distancia.celular.total_computado, "duracao")
    renderServ(ligacoes.longa_distancia.celular.consumo_tipos)
    renderDetail("Fixo", 3, ligacoes.longa_distancia.fixo.total_computado, "duracao")
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

  def self.renderDetail(title, level, consumo, medida)
    i = 0
    strLevel = ""
    strDetailLevel = ""
    strUnidade = ""
    strMedida = ""

    loop do
      i += 1
      strDetailLevel += "--|"
      if (i + 1) == level then
        strLevel += strDetailLevel
      end
      break if level == i
    end

    if medida == "duracao" then
      strMedida = "Duração Total"
      strUnidade = Time.at(consumo.unidade_total).utc.strftime("%H:%M:%S")
    else
      strUnidade = consumo.unidade_total.to_s

      if medida == "bytes" then
        strMedida = "Quantidade Total de Bytes"
      else
        strMedida = "Quantidade Total"
      end
    end

    puts "|" + strLevel + " " + title + ":"
    puts "|" + strDetailLevel + " " + strMedida + ": " +  strUnidade
    puts "|" + strDetailLevel + " Valor Total: " +  consumo.valor_total.to_s
    puts "|" + strDetailLevel + " Total de Registros: " +  consumo.quantidade_registros.to_s

  end
end
