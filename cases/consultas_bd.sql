--  ------------- Desafio Looqbox -------------------------------------

-- Analisando a estrutura das tabelas

DESCRIBE IMDB_movies; -- Tabela de d_atores

DESCRIBE data_product; -- Tabela de d_produtos

DESCRIBE data_product_sales; -- Tabela de f_produtos_vendidos

DESCRIBE data_store_cad; -- Tabela d_info_lojas

DESCRIBE data_store_sales; -- Tabela de f_vendas

-- --------------------------------------------------------------------

#01 - Quais são os 10 produtos mais caros da empresa?

# Validando os produtos unicos
SELECT
    COUNT(DISTINCT dp.PRODUCT_COD) AS distintos,
    COUNT(dp.PRODUCT_COD)          AS total_linhas
FROM data_product dp;

SELECT 
dp.PRODUCT_NAME  AS produto,
dp.PRODUCT_VAL  AS valor,
dp.DEP_NAME 
FROM data_product dp 
ORDER  BY dp.PRODUCT_VAL DESC 
LIMIT 10



# 2 - Quais são as seções dos departamentos 'BEBIDAS' e 'PADARIA'?

SELECT DISTINCT 
dp.SECTION_COD AS codigo_secao,
dp.SECTION_NAME as nome_secao
FROM data_product dp 
WHERE  dp.SECTION_NAME  in ('BEBIDAS', 'PADARIA')


# 3 - Qual foi o total de vendas de produtos (em dólares) de cada área de negócios no primeiro trimestre de 2019?

SELECT 
dsc.BUSINESS_NAME  as area_negocio,
CONCAT('$ ', FORMAT(SUM(dss.SALES_VALUE * dss.SALES_QTY),2)) as receita
FROM data_store_cad dsc 
INNER JOIN data_store_sales dss  ON dss.STORE_CODE = dsc.STORE_CODE 
WHERE YEAR(dss.`DATE` ) =  2019
	AND MONTH(dss.`DATE`) BETWEEN  1 AND 3 -- coletando 1 Tri
GROUP BY dsc.BUSINESS_NAME
ORDER BY receita DESC;