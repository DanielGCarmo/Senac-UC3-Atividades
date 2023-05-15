USE hospital;

-- INSERTs DE DADOS AUSENTES NECESSÁRIOS PARA AS CONSULTAS --

/*INSERT DE CONSULTAS SEM CONVENIO, até então inexistentes no banco de dados.*/
INSERT INTO consulta (data_consulta, valor, paciente_id, medico_id, especialidade_id, convenio_id) VALUES
('2020-08-08 09:30:00', 55.00, 5, 3, 2, null),
('2020-03-12 11:45:00', 45.00, 1, 4, 1, null),
('2020-04-01 16:15:00', 80.00, 3, 9, 3, null);

/*INSERT DE DADOS NA TABELA "Médico-Especialidade". */
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES
(1, 1), (1, 2), (2, 2), (3, 3), (4, 1), (4, 3), 
(5, 4), (6, 2), (7, 1),(8, 1), (9, 2), (10, 2), 
(11, 4), (11, 1), (12, 1), (13, 3), (13, 2);

---------------------------------------------------------------------

/* Consulta 1:
Todos os dados e o valor médio das consultas do ano de 2020 realizadas SEM convênio. */
SELECT consulta.*,
	paciente.nome AS nome_paciente,
	medico.nome AS nome_medico,
	especialidade.especialidade AS nome_especialidade, (
		SELECT AVG(valor) FROM consulta WHERE YEAR(data_consulta) IN ('2020') AND convenio_id IS NULL
		) AS media_consultas_sem_convenio_2020
FROM consulta
JOIN paciente ON consulta.paciente_id = paciente.id
JOIN medico ON consulta.medico_id = medico.id
JOIN especialidade ON consulta.especialidade_id = especialidade.id
WHERE YEAR(data_consulta) IN ('2020') AND convenio_id IS NULL
ORDER BY data_consulta ASC;

/*Consulta 2:
Todos os dados e o valor médio das consultas do ano de 2020 realizadas POR convênio. */
SELECT c.id AS consulta_id,
    c.data_consulta, 
    c.valor, 
    p.nome AS nome_paciente, 
    m.nome AS nome_medico, 
    e.especialidade AS especialidade, 
    cv.nome_convenio AS nome_convenio, 
    cv.id AS convenio_id,
    AVG(c.valor) OVER (PARTITION BY cv.id) AS valor_medio_consultas_por_convenio_2020 -- (para particionar linhas de tabela em grupos)
FROM consulta c
JOIN paciente p ON c.paciente_id = p.id
JOIN medico m ON c.medico_id = m.id
JOIN especialidade e ON c.especialidade_id = e.id
LEFT JOIN convenio cv ON c.convenio_id = cv.id
WHERE YEAR(c.data_consulta) IN ('2020') AND cv.id IS NOT NULL
ORDER BY cv.id ASC, c.data_consulta DESC;

/* Consulta 3:
Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta. */
SELECT * FROM internacao WHERE data_efetiva_alta > data_prevista_alta;

/* Consulta 4:
Receituário completo da primeira consulta registrada com receituário associado. */
SELECT c.id AS 'Consulta',
	m.nome AS 'Médico',
	p.nome AS 'Paciente',
	r.medicamentos AS 'Medicamento'
FROM consulta c
JOIN medico m ON c.medico_id = m.id
JOIN paciente p ON c.paciente_id = p.id
JOIN receita r ON c.id = r.consulta_id
WHERE c.id = (SELECT MIN(id) FROM consulta WHERE id IN (SELECT consulta_id FROM receita));

/* Consulta 5:
Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio). */
SELECT c1.*
FROM consulta c1
WHERE c1.convenio_id IS NULL AND c1.valor = (
	SELECT MAX(valor) FROM consulta WHERE convenio_id IS NULL
)
UNION ALL -- > (distribui os resultados de várias instruções SELECT em uma única linha de resultado)
SELECT c2.*
FROM consulta c2
WHERE c2.convenio_id IS NULL AND c2.valor = (
    SELECT MIN(valor) FROM consulta WHERE convenio_id IS NULL
);

/* Consulta 6: 
Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta. */
SELECT 
    i.id AS 'ID Internação',
    p.nome AS 'Paciente',
    m.nome AS 'Médico',
    i.quarto_id AS 'ID do Quarto',
    q.numero AS 'Número do Quarto',
    t.descricao AS 'Tipo de Quarto',
    i.data_entrada AS 'Data de Entrada',
    i.data_prevista_alta AS 'Data Prevista de Alta',
    i.data_efetiva_alta AS 'Data Efetiva de Alta',
    DATEDIFF(i.data_efetiva_alta, i.data_entrada)  AS 'Dias de Internação',
    i.procedimento AS 'Procedimento Realizado',
	(DATEDIFF(i.data_efetiva_alta, i.data_entrada) + 1) * t.valor_diaria AS 'Total da Internação'
FROM internacao i
INNER JOIN paciente p ON i.paciente_id = p.id
INNER JOIN medico m ON i.medico_id = m.id
INNER JOIN quarto q ON i.quarto_id = q.id_quarto
INNER JOIN tipo_quarto t ON q.tipo_id = t.id_tipo
ORDER BY i.data_entrada;

/* Consulta 7: 
Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”. */
SELECT
	i.data_entrada AS 'Data', 
    i.procedimento AS 'Procedimento', 
    q.numero AS 'Quarto'
FROM internacao i
INNER JOIN quarto q ON i.quarto_id = q.id_quarto
INNER JOIN tipo_quarto tq ON q.tipo_id = tq.id_tipo
WHERE tq.descricao = 'Apartamento';

/* Consulta 8: 
Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta 
e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta */
SELECT
	paciente.nome AS "Paciente",
    consulta.data_consulta AS "Data da Consulta",
    especialidade.especialidade AS "Especialidade"
FROM consulta
JOIN paciente ON consulta.paciente_id = paciente.id 
JOIN especialidade ON consulta.especialidade_id = especialidade.id 
WHERE paciente.nascimento > DATE_SUB(consulta.data_consulta, INTERVAL 18 YEAR) -- > DATE_SUB() Subtrair um valor de tempo (intervalo) de uma data
	AND especialidade.especialidade <> "Pediatria"
ORDER BY consulta.data_consulta;


/* Consulta 9: 
Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, 
que tenham acontecido em “enfermaria”. */
SELECT
	p.nome AS 'Paciente', 
    m.nome AS 'Médico', 
    i.data_entrada AS 'Internação',
    i.procedimento AS 'Procedimento',
    e.especialidade AS 'Especialidade',
    tq.descricao AS 'Local'
FROM paciente p 
JOIN internacao i ON p.id = i.paciente_id 
JOIN medico m ON m.id = i.medico_id
JOIN medico_especialidade me ON me.id_medico = m.id
JOIN especialidade e ON e.id = me.id_especialidade
JOIN quarto q ON q.id_quarto = i.quarto_id
JOIN tipo_quarto tq ON tq.id_tipo = q.tipo_id
WHERE e.especialidade = 'Gastroenterologia' AND tq.descricao = 'Enfermaria' 
ORDER BY i.data_entrada DESC;

/* Consulta 10: 
Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou. */
SELECT
	m.nome AS 'Nome', 
    m.crm AS 'CRM', 
    COUNT(*) AS 'Quantidade de Consultas' -- The COUNT() function returns the number of records returned by a select query.
FROM medico m 
JOIN consulta c ON c.medico_id = m.id 
GROUP BY m.id;

/* Consulta 11: 
Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação */
SELECT e.nome, e.cre, COUNT(*) AS num_internacoes
FROM internacao_enfermeiro ie
JOIN enfermeiro e ON ie.enfermeiro_id = e.id
GROUP BY e.nome, e.cre
HAVING COUNT(*) > 1; 
-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
-- No caso, a cláusula HAVING filtra apenas os enfermeiros que participaram de mais de uma internação.

/* Consulta extra:
Retorna o nome do médico, a especialidade e a quantidade de consultas realizadas por cada médico.
Exclui dados de médicos que não realizaram nenhuma consulta.
Esta consulta envolve quatro tabelas: medico, especialidade, medico_especialidade e consulta */
SELECT 
	m.nome AS 'Médico', 
	e.especialidade AS 'Especialidade',
    COUNT(c.id) AS 'Total de Consultas'
FROM medico m
JOIN medico_especialidade me ON m.id = me.id_medico
JOIN especialidade e ON me.id_especialidade = e.id
LEFT JOIN consulta c ON m.id = c.medico_id
GROUP BY m.nome, e.especialidade
HAVING COUNT(c.id) > 0
ORDER BY m.nome, e.especialidade;