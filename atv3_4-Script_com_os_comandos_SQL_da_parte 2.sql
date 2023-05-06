USE hospital;

-- Adicionando a coluna "em atividade" na tabela médicos
ALTER TABLE medico ADD em_atividade BIT;

-- Atualização da coluna "em atividade" dos médicos
UPDATE medico SET em_atividade = 1 WHERE id IN (1, 3, 5, 7, 9, 10, 11, 12, 13);
UPDATE medico SET em_atividade = 0 WHERE id IN (2, 4, 6, 8);

-- Atualização das datas de alta nas internações em quartos de enfermaria para três dias após a entrada
UPDATE internacao SET
data_prevista_alta = DATE_ADD(data_entrada, INTERVAL 3 DAY), 
data_efetiva_alta = DATE_ADD(data_entrada, INTERVAL 4 DAY)
WHERE quarto_id = 3;

-- Exclusão do último convênio e todas as consultas realizadas com esse convênio
ALTER TABLE paciente DROP CONSTRAINT paciente_ibfk_1;
ALTER TABLE paciente ADD CONSTRAINT paciente_ibfk_1 FOREIGN KEY(id_convenio) REFERENCES convenio(id) ON DELETE SET NULL;
ALTER TABLE consulta DROP CONSTRAINT consulta_ibfk_1;
ALTER TABLE consulta ADD CONSTRAINT consulta_ibfk_1 FOREIGN KEY(convenio_id) REFERENCES convenio(id) ON DELETE CASCADE;
ALTER TABLE consulta DROP CONSTRAINT consulta_ibfk_4;
ALTER TABLE consulta ADD CONSTRAINT consulta_ibfk_4 FOREIGN KEY(convenio_id) REFERENCES convenio(id) ON DELETE CASCADE;
ALTER TABLE internacao MODIFY paciente_id INT;
ALTER TABLE internacao DROP CONSTRAINT internacao_ibfk_2;
ALTER TABLE internacao ADD CONSTRAINT internacao_ibfk_2 FOREIGN KEY(paciente_id) REFERENCES paciente(id) ON DELETE SET NULL;
ALTER TABLE internacao_enfermeiro MODIFY internacao_id INT;
ALTER TABLE internacao_enfermeiro DROP CONSTRAINT internacao_enfermeiro_ibfk_1;
ALTER TABLE internacao_enfermeiro ADD CONSTRAINT internacao_enfermeiro_ibfk_1 FOREIGN KEY(internacao_id) REFERENCES internacao(id) ON DELETE SET NULL;
DELETE FROM convenio WHERE id = 4;
DELETE FROM consulta WHERE convenio_id = 4;