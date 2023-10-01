--Exercicio 1:
SELECT * FROM T_SAK_FUNCIONARIO
ORDER BY DT_ADMISSAO ASC;

--Exercicio 2:
SELECT * FROM T_SAK_PROJETO
ORDER BY dt_inicio ASC;

--Exercicio 3:
SELECT * FROM T_SAK_PROJETO
WHERE dt_termino is not null;

--Exercicio 4:
SELECT 
    cd_func AS ID,
    cd_depto AS ID_DEPTO,
    nm_funcionario AS NOME,
    dt_nascimento AS ANIVSERSARIO,
    ds_estado_civil AS ESTADO_CIVIL,
    vl_salario AS SALARIO,
    dt_admissao AS DT_ENTRADA
FROM 
    T_SAK_FUNCIONARIO  
WHERE 
    cd_depto IN (7, 10, 60);
    

--Exercicio 5:
SELECT
    cd_func AS "Código do Funcionário",
    nm_funcionario AS "Nome do Funcionário",
    vl_salario AS "Valor Salário",
    TO_CHAR(dt_admissao, 'DD/MM/YYYY') AS "Data de Admissão"
FROM
    t_sak_funcionario 
WHERE
    cd_depto IN (1234, 10, 30, 60, 70)
    AND vl_salario > 1000
ORDER BY
    cd_func;

--Exercicio 6:
SELECT * FROM t_sak_funcionario
WHERE ds_estado_civil = 'SOLTEIRO' OR ds_estado_civil = 'SOLTEIRA';

--Exercicio 7:
SELECT *
FROM t_sak_funcionario
WHERE TO_CHAR(dt_admissao, 'DD/MM/YYYY') BETWEEN '01/01/2000' AND '31/12/2000';

--Exercicio 8:
SELECT *
FROM (
    SELECT *
    FROM T_SAK_PROJETO
    ORDER BY vl_budget_projeto DESC
)
WHERE ROWNUM <= 2;

--Exercicio 9:
SELECT *
FROM T_SAK_PROJETO
WHERE dt_termino is null
  AND vl_budget_projeto > (SELECT AVG(vl_budget_projeto) FROM T_SAK_PROJETO WHERE dt_termino is null);
  
--Exercicio 10:
SELECT *
FROM T_SAK_DEPTO
WHERE cd_depto NOT IN (SELECT DISTINCT cd_depto FROM T_SAK_FUNCIONARIO);
    


