SELECT
	SUBSTR(tp.CO_IBGE, 0, 2) AS "CO_UF",
	tu.SG_UF AS "SG_UF",
	TO_CHAR(TP.CO_IBGE) AS "CO_MUNICIPIO_IBGE",
	TM.NO_MUNICIPIO AS "NO_MUNICIPIO",
	TPE.CO_CNES_ESTABELECIMENTO AS "CO_CNES",
	TPE.DT_POSICAO_ESTOQUE AS "DT_POSICAO_ESTOQUE",
	TP2.NU_PRODUTO AS "CO_CATMAT",
	TP3.DS_PRODUTO AS "DS_PRODUTO",
	TIPE.QT_ITENS AS "QT_ESTOQUE",
	TP2.NU_LOTE AS "NU_LOTE",
	TP2.DT_VALIDADE AS "DT_VALIDADE",
	tipe.TP_PRODUTO AS "TP_PRODUTO",
	TIPE.SG_PROGRAMA_SAUDE AS "SG_PROGRAMA_SAUDE",
	TPS.DS_PROGRAMA_SAUDE  AS "DS_PROGRAMA_SAUDE",
	'SOA_BNAFAR' AS "SG_ORIGEM"
FROM
	DBBNAFARSOA.TB_POSICAO_ESTOQUE tpe 
LEFT JOIN 
	DBBNAFARSOA.RL_PROTOCOLO_POSICAOESTOQUE rpp ON
	RPP.CO_POSICAO_ESTOQUE = TPE.CO_SEQ_POSICAO_ESTOQUE 
LEFT JOIN 
	DBBNAFARSOA.TB_PROTOCOLO tp ON
	TP.CO_SEQ_PROTOCOLO  = RPP.CO_PROTOCOLO 
LEFT JOIN 
	DBBNAFARSOA.TB_ITEM_POSICAO_ESTOQUE tipe ON
	TIPE.CO_POSICAO_ESTOQUE = TPE.CO_SEQ_POSICAO_ESTOQUE 
LEFT JOIN 
	DBBNAFARSOA.TB_PRODUTO tp2 ON
	TP2.CO_SEQ_PRODUTO =TIPE.CO_PRODUTO 
LEFT JOIN 
	DBHORUS.TB_PRODUTO tp3 ON
	TP2.NU_PRODUTO = TP3.NU_PRODUTO 
LEFT JOIN 
	DBHORUS.TB_PROGRAMA_SAUDEM tps ON
	TIPE.SG_PROGRAMA_SAUDE = TPS.SG_PROGRAMA_SAUDE 
LEFT JOIN 
	DBGERAL.TB_MUNICIPIO tm ON
	TM.CO_MUNICIPIO_IBGE = TP.CO_IBGE
LEFT JOIN 
	DBGERAL.TB_UF tu ON
	TU.CO_UF_IBGE = SUBSTR(tp.CO_IBGE,0, 2)
WHERE
	TPE.DT_POSICAO_ESTOQUE BETWEEN TO_DATE('2023-11-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-09', 'YYYY-MM-DD')
UNION
SELECT 
	CASE
		WHEN TP.CO_UF_IBGE IS NOT NULL THEN TP.CO_UF_IBGE
		ELSE SUBSTR(tp.CO_MUNICIPIO_IBGE, 0, 2)
	END AS "CO_UF",
	TU.SG_UF AS "SG_UF",
	TO_CHAR(TP.CO_MUNICIPIO_IBGE) AS "CO_MUNICIPIO_IBGE",
	TM.NO_MUNICIPIO AS "NO_MUNICIPIO",
	TPE.CO_CNES AS "CO_CNES",
	TPE.DT_POSICAO_ESTOQUE AS "DT_POSICAO_ESTOQUE",
	TPE.NU_PRODUTO AS "CO_CATMAT",
	TP2.DS_PRODUTO AS "DS_PRODUTO",
	TPE.QT_MEDICAMENTO AS "QT_ESTOQUE",
	TPE.NU_LOTE AS "NU_LOTE",
	TPE.DT_VALIDADE AS "DT_VALIDADE",
	TPE.TP_PRODUTO AS "TP_PRODUTO",
	TPE.SG_PROGRAMA_SAUDE AS "SG_PROGRAMA_SAUDE",
	TPS.DS_PROGRAMA_SAUDE AS "DS_PROGRAMA_SAUDE",
	'WSBNDAF' AS "SG_ORIGEM"
FROM
	DBWSHORUS.TB_POSICAO_ESTOQUE TPE
LEFT JOIN
	DBWSHORUS.TB_PROTOCOLO tp ON
	TP.NU_PROTOCOLO_ENTRADA = TPE.NU_PROTOCOLO_ENTRADA
LEFT JOIN
	DBHORUS.TB_PRODUTO TP2 ON
	TPE.NU_PRODUTO_SEM_TP_PRODUTO = TP2.NU_PRODUTO
LEFT JOIN
	DBGERAL.TB_MUNICIPIO TM ON
	TM.CO_MUNICIPIO_IBGE = TP.CO_MUNICIPIO_IBGE
LEFT JOIN
	DBHORUS.TB_PROGRAMA_SAUDEM TPS ON
	TPE.SG_PROGRAMA_SAUDE = TPS.SG_PROGRAMA_SAUDE
LEFT JOIN
	DBGERAL.TB_UF tu ON
	TU.CO_UF_IBGE = SUBSTR(TP.CO_MUNICIPIO_IBGE, 0, 2)
	OR TU.CO_UF_IBGE = TP.CO_UF_IBGE
WHERE
	TPE.DT_POSICAO_ESTOQUE BETWEEN TO_DATE('2023-11-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-09', 'YYYY-MM-DD')
UNION
SELECT
	SUBSTR(TUD.CO_MUNICIPIO_IBGE, 0, 2) AS "CO_UF",
	tu.SG_UF AS "SG_UF",
	TO_CHAR(TUD.CO_MUNICIPIO_IBGE) AS "CO_MUNICIPIO_IBGE",
	TM.NO_MUNICIPIO AS "NO_MUNICIPIO",
	TUD.CO_UNIDADE_CNES AS "CO_CNES",
	TRUNC(SYSDATE) AS "DT_POSICAO_ESTOQUE",
	TP4.NU_PRODUTO AS "CO_CATMAT",
	TP4.DS_PRODUTO AS "DS_PRODUTO",
	RLL.QT_SALDO AS "QT_ESTOQUE",
	TIL.NU_LOTE AS "NU_LOTE",
	TIL.DT_VALIDADE AS "DT_VALIDADE",
	TP4.TP_PRODUTO AS "TP_PRODUTO",
	TPS2.SG_PROGRAMA_SAUDE AS "SG_PROGRAMA_SAUDE",
	TPS2.DS_PROGRAMA_SAUDE  AS "DS_PROGRAMA_SAUDE",
	'HORUS' AS "SG_ORIGEM"
FROM
	DBHORUS.RL_LOCALFISICA_LOTEPRGSAUDE RLL 
LEFT JOIN
	DBHORUS.TB_UNIDADE_DISPENSACAO TUD ON
	RLL.CO_UNIDADE_DISPENSACAO = TUD.CO_SEQ_UNIDADE_DISPENSACAO
LEFT JOIN
	DBGERAL.TB_MUNICIPIO TM ON
	TM.CO_MUNICIPIO_IBGE = TUD.CO_MUNICIPIO_IBGE
LEFT JOIN
	DBGERAL.TB_UF TU ON
	TU.CO_UF_IBGE = SUBSTR(TUD.CO_MUNICIPIO_IBGE,0, 2)
LEFT JOIN
	DBHORUS.TB_PRODUTO TP4 ON
	TP4.CO_SEQ_PRODUTO = RLL.CO_PRODUTO
LEFT JOIN 
	DBHORUS.TB_PROGRAMA_SAUDEM tps2 ON
	TPS2.CO_SEQ_PROGRAMA_SAUDE = RLL.CO_PROGRAMA_SAUDE
LEFT JOIN 
	DBHORUS.RL_LOTE_PROGRAMA_SAUDE rlps ON
	RLPS.CO_SEQ_LOTE_PROGRAMA_SAUDE = RLL.CO_LOTE_PROGRAMA_SAUDE
LEFT JOIN 
	DBHORUS.TB_ITEM_LOTE til ON
	RLPS.CO_ITEM_LOTE = TIL.CO_SEQ_ITEM_LOTE;