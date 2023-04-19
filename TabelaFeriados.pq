TabelaFeriados = 
ADDCOLUMNS(
    FILTER(
        Calendario,
        Calendario[Feriados Nacionais] <> BLANK()
    ),
    "DataFeriado", Calendario[Feriados Nacionais],
    "NomeFeriado", Calendario[Feriados Nacionais]
)
