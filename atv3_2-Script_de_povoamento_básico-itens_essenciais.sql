USE hospital;

-- Inserção de tipos de quarto
INSERT INTO tipo_quarto (descricao, valor_diaria) VALUES
('Apartamento', 500.00),
('Quarto Duplo', 300.00),
('Enfermaria', 150.00);

-- Inserção de convênios
INSERT INTO convenio (nome_convenio, cnpj, carencia, carteira_convenio) VALUES 
('MedMais', '49.983.834/0001-40', '2017-01-01', 123456),
('Pro Health', '81.867.101/0001-68', '2018-06-01', 654321),
('UniSaude', '63.982.115/0001-52', '2019-03-15', 789456),
('Vida & Saúde', '12.345.678/0001-90', '2020-09-01', 987654);

-- Inserção de especialidades
INSERT INTO especialidade (especialidade) VALUES 
('Pediatria'), 
('Clínico Geral'), 
('Gastroenterologia'), 
('Dermatologia'),
('Cardiologia'),
('Neurologia'),
('Psiquiatria');