Dias úeis = 
VAR DataInicial = DATE(2023, 3, 26)
VAR DataFinal = DATE(2023, 4, 25)
VAR Feriados = FILTER('TabelaFeriados', 'TabelaFeriados'[Data] >= DataInicial && 'TabelaFeriados'[Data] <= DataFinal)
VAR DiasUteis = NETWORKDAYS(DataInicial, DataFinal, Feriados)
RETURN 
SUMX(VALUES('TabelaFeriados'[Data]), IF(WEEKDAY('TabelaFeriados'[Data],2) <= 5 && NOT('TabelaFeriados'[Data] IN Feriados), 1, 0))