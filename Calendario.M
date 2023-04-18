let
    Fonte = #table(
        {"Data"},
        List.Dates(
            #date(2023,1,1),
            Duration.Days(#date(2023,12,31) - #date(2023,1,1)) + 1,
            #duration(1,0,0,0)
        )
    ),
    Tipo = Table.TransformColumnTypes(Fonte,{{"Data", type date}}),
    Feriados = {
        #date(2023,1,1),
        #date(2023,4,21),
        #date(2023,5,1),
        #date(2023,9,7),
        #date(2023,10,12),
        #date(2023,11,2),
        #date(2023,11,15),
        #date(2023,12,25)
    },
    DiasUteis = Table.AddColumn(Tipo, "Dias Uteis com Domingos", each if Date.DayOfWeek([Data]) = 1 then false else not List.Contains(Feriados, [Data])),
    #"Dias Uteis Numerico" = Table.TransformColumnTypes(DiasUteis,{{"Dias Uteis com Domingos", Int64.Type}})
in
    #"Dias Uteis Numerico"
