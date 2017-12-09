/*******************************************************************************
**   PROGRAMA.: converte-numerais.p
**   OBJETIVO.: Converter Numerais Arábico para Romano e Vice-Versa.
**   AUTOR....: Alberto Duzi
**   EMPRESA..: EIT Technologies
**   DATA.....: 08/12/2017
*******************************************************************************/

/* --- Definições de Parâmetros e Variáveis --- */
DEF VAR i-valor-arabico     AS INTE INIT 0      NO-UNDO.
DEF VAR c-valor-romano      AS CHAR INIT ""     NO-UNDO.
DEF VAR c-resultado         AS CHAR INIT ""     NO-UNDO.

DEF VAR i-tipo              AS INTE INIT 1      NO-UNDO.
DEF VAR i-contador          AS INTE INIT 0      NO-UNDO.

DEF FRAME f-texto
    "Digite o Tipo de Conversão que Deseja Realizar : "    SKIP
    " 1 - Arabico para Romano. "                           SKIP
    " 2 - Romano  para Arábico. "
    WITH 1 COL WIDTH 80.

DEF FRAME f-tipo
    i-tipo      FORMAT "9"  LABEL "Tipo"
    WITH WIDTH 80 SIDE-LABELS.

DEF FRAME f-arabico
    i-valor-arabico LABEL "Valor Arábico"
    WITH WIDTH 80 SIDE-LABELS.

DEF FRAME f-romano
    c-valor-romano LABEL "Valor Romano"
    WITH WIDTH 80 SIDE-LABELS.

DEF FRAME f-result-arabico
    c-resultado LABEL "Resultado em Romano"
    WITH WIDTH 80 SIDE-LABELS.

DEF FRAME f-result-romano
    i-contador LABEL "Resultado em Arábico"
    WITH WIDTH 80 SIDE-LABELS.

DEF FRAME f-erro
    "O Numeral digitado é muito longo ou incorreto!"
    WITH WIDTH 80 SIDE-LABELS.

/* --- Inicia Interação ao Usuário --- */
VIEW FRAME f-texto.
    
/* --- Informa o Tipo de Conversão --- */
UPDATE i-tipo
    WITH FRAME f-tipo.

/* --- Informa Valor a Converter de acordo com o Tipo --- */
IF i-tipo = 1 THEN
    UPDATE i-valor-arabico
        WITH FRAME f-arabico.
ELSE
    UPDATE c-valor-romano
        WITH FRAME f-romano.

/* --- Execução da Lógica --- */
RUN pi-executa.

IF i-contador >= 9999 THEN
    VIEW FRAME f-erro.
ELSE DO:
    /* --- Mostra o Reultado de acordo com o Tipo --- */
    IF i-tipo = 1 THEN
        DISP c-resultado
            WITH FRAME f-result-arabico.
    ELSE
        DISP i-contador
            WITH FRAME f-result-romano.
END.

PROCEDURE pi-executa :

    /* --- Soma Contador de Arábicos --- */
    DO i-contador = 1 TO 9999 :
    
        /* --- Executa conversão de Arábicos para Romanos --- */
        RUN pi-ArabicToRoman (INPUT i-contador, 
                              OUTPUT c-resultado).
    
        CASE i-tipo :
            /* --- Converte Arábico --- */
            WHEN 1 THEN IF i-valor-arabico = i-contador  THEN LEAVE.
            /* --- Converte Romano --- */
            WHEN 2 THEN IF c-valor-romano  = c-resultado THEN LEAVE.
            OTHERWISE
                LEAVE.
        END CASE.
    
    END.

END PROCEDURE.

PROCEDURE pi-ArabicToRoman :

    DEF INPUT  PARAM p-numero     AS INTE     NO-UNDO.
    DEF OUTPUT PARAM p-resultado  AS CHAR     NO-UNDO.

    DEF VAR i-arabicos          AS INTE                 EXTENT 13 INIT[  1,    4,   5,    9,  10,   40,  50,   90, 100,  400, 500,  900, 1000]  NO-UNDO.
    DEF VAR c-romanos           AS CHAR FORMAT "x(02)"  EXTENT 13 INIT["I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD", "D", "CM", "M"]   NO-UNDO.
    DEF VAR i-indice            AS INTE                           INIT 0                                                                        NO-UNDO.

    ASSIGN i-indice = EXTENT(i-arabicos).

    DO WHILE p-numero > 0 :
        IF p-numero >= i-arabicos[i-indice] THEN
            ASSIGN p-resultado = p-resultado + c-romanos[i-indice]
                   p-numero    = p-numero   - i-arabicos[i-indice].
        ELSE
            ASSIGN i-indice = i-indice - 1.
    END.

END PROCEDURE.
