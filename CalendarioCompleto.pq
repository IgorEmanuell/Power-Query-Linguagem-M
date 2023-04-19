let
    dataInicial = #date(2023,1,1),
    dataFinal = #date(2023,12,31),

    //Lista de datas entre a data inicial e final
    listaDatas = List.Dates(dataInicial, Duration.Days(dataFinal - dataInicial) +1, #duration(1,0,0,0)),

    //Transformando a lista de datas em uma tabela
    tabelaDatas = Table.FromList(listaDatas, Splitter.SplitByNothing(), {"Data"}, null, ExtraValues.Error),

    //Coluna para o dia da semana
    diaSemana = Table.AddColumn(tabelaDatas, "Dia da Semana", each Date.DayOfWeek([Data]), Int64.Type),

    //Criando colunas para o dia, mês e ano
    dia = Table.AddColumn(diaSemana, "Dia", each Date.Day([Data]), Int64.Type),
    mes = Table.AddColumn(dia, "Mês", each Date.Month([Data]), Int64.Type),
    ano = Table.AddColumn(mes, "Ano", each Date.Year([Data]), Int64.Type),

    //Coluna para identificar os feriados nacionais
    feriadosNacionais = Table.AddColumn(ano, "Feriados Nacionais", each
    if Date.Day([Data]) = 1 and Date.Month([Data]) = 1 then "Ano Novo"
    else if Date.Day([Data]) = 7 and Date.Month([Data]) = 4 then "Sexta-Feira da Paixão"
    else if Date.Day([Data])  = 8 and Date.Month([Data]) = 4 then "Prolongado"
    else if Date.Day([Data]) = 21 and Date.Month([Data]) = 4 then "Tiradentes"
    else if Date.Day([Data])  = 22 and Date.Month([Data]) = 4 then "Prolongado"
    else if Date.Day([Data])= 1 and Date.Month([Data]) = 5 then "Dia do Trabalho"
    else if Date.Day([Data]) = 7 and Date.Month([Data]) = 9 then "Dia da Indepêndencia"
    else if Date.Day([Data]) = 12 and Date.Month([Data]) = 10 then "Nossa Senhora Aparecida"
    else if Date.Day([Data]) = 2 and Date.Month([Data]) = 11 then "Finados"
    else if Date.Day([Data]) = 15 and Date.Month([Data]) = 11 then "Proclamação da República"
    else if Date.Day([Data]) = 25 and Date.Month([Data]) = 12 then "Natal"
    else null),

    //Removendo as colunas que não são necessárias 
    removerColunas = Table.SelectColumns(feriadosNacionais, {"Data", "Dia da Semana", "Dia", "Mês", "Ano", "Feriados Nacionais"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(removerColunas,{{"Data", type date}})
in
    #"Tipo Alterado"