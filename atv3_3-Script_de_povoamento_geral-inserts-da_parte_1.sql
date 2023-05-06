USE hospital;

-- Inserção de dados de pacientes
INSERT INTO paciente(nome, nascimento, endereco, telefone, email, cpf, rg, id_convenio) VALUES
('Armindo Moreira Azeredo', '1995-02-10', 'Rua dos Ipês, 123', '(21) 9999-1234', 'armindo@gmail.com', '12345678901', '12345678', 1),
('Cármen Mata Camargo', '1982-07-15', 'Avenida das Flores, 456', '(11) 98888-4567', 'carmen@hotmail.com', '23456789012', '23456789', 2),
('César Sítima Faria', '1979-11-28', 'Rua das Oliveiras, 789', '(31) 97777-7890', 'cesar@gmail.com', '34567890123', '34567890', 3),
('Evandro Trindade Bouça', '2000-05-22', 'Rua das Palmeiras, 345', '(22) 98888-3456', 'evandro@gmail.com', '45678901234', '45678901', 2),
('Fabrício Norões Xavier', '1992-03-12', 'Avenida dos Pinheiros, 678', '(11) 99999-1234', 'fabricio@hotmail.com', '56789012345', '56789012', 4),
('Francisca Parracho Caneira', '1985-09-01', 'Rua das Acácias, 234', '(81) 98888-4567', 'francisca@hotmail.com', '67890123456', '67890123', 1),
('Giovanni Arouca Mata', '1978-12-27', 'Avenida dos Girassóis, 123', '(11) 97777-7890', 'giovanni@gmail.com', '78901234567', '78901234', 2),
('Helton Espinosa', '1999-08-04', 'Rua dos Lírios, 789', '(21) 99999-3456', 'helton@hotmail.com', '89012345678', '89012345', 3),
('Ivo Brandão Palos', '1975-06-17', 'Avenida das Orquídeas, 456', '(31) 98888-1234', 'ivo@gmail.com', '90123456789', '90123456', 2),
('Karine Macena Porciúncula', '1988-04-08', 'Rua das Camélias, 234', '(22) 97777-7890', 'karine@hotmail.com', '01234567890', '01234567', 4),
('Mark Festas Santana', '1997-01-02', 'Avenida das Margaridas, 123', '(11) 98888-3456', 'mark@gmail.com', '12345678902', '12345679', 1),
('Pablo Atilano Flores', '1981-10-26', 'Rua das Violetas, 456', '(81) 99999-1234', 'pablo@hotmail.com', '23456789013', '23456788', 3),
('Silvana Fartaria Nazário', '1984-12-08', 'Avenida dos Cravos, 678', '(31) 97777-4567', 'silvana@gmail.com', '34567890124', '34567891', 2),
('Zilda Gomide Osório', '1985-05-15', 'Rua das Flores, 123', '(11) 1234-5678', 'zilda.osorio@email.com', '12345678903', '1234567', 1);

-- Inserção de dados de médicos
INSERT INTO medico (nome, nascimento, cpf, crm, uf_crm, telefone, endereco) VALUES
('Anny Quintanilha', '1970-11-10', '86132473009', '120935', 'RS', '(69) 3752-5488', 'Rua Flores, 10, apto 101'),
('Suéli Simão Pegado', '1990-08-27', '62876978067', '15891', 'SP', '(97) 2810-2734', 'Avenida Japão, 50'),
('Alisson Sacramento', '1981-01-15', '80814279023', '178105', 'MG', '(79) 2718-0264', 'Rua Albieri, 480'),
('Lívia Veloso', '1972-03-22', '20924987030', '17897', 'MG', '(61) 3019-1483', 'Travessa A, 89'),
('Gael Milheiro Lemes', '1964-02-13', '38603737061', '9826', 'RS', '(82) 2433-7762', 'Rua das Rosas, 80, apto 200'),
('Gisela Espinosa', '1980-09-12', '23529091049', '34548', 'SP', '(86) 3368-4812', 'Avenida Santos, 90'),
('Nelson Anjos Palmeira', '1980-10-14', '03626639045', '344789', 'SP', '(54) 3941-4795', 'Rua Álamo, 180, ap 90'),
('Ezequiel Pestana Henriques', '1979-06-30', '67297959057', '9756', 'RS', '(69) 2537-6076', 'Avenida Chateaubriand, 150'),
('Tito Carqueijeiro', '1973-05-19', '32972518080', '14777', 'RS', '(83) 3272-8326', 'Rua Flores, 670'),
('Fabiano Gomide', '1989-08-31', '01234567899', '65765', 'RS', '(63) 3230-5071', 'Avenida das Águas, 600'),
('Cristovão Xavier', '1979-12-12', '92690490005', '67432', 'RS', '(24) 2448-9465', 'Rua da Luz, 80'),
('Alberto Veríssimo', '1986-06-26', '70600178013', '13548', 'SP', '(67) 3754-8886', 'Avenida  das aves, 9912, apto 60'),
('Júlia Camarinho', '1980-07-05', '74492596054', '24654', 'MG', '(61) 2615-4776', 'Rua Albieri, 590');

-- Inserção de consultas
INSERT INTO consulta (data_consulta, valor, paciente_id, medico_id, especialidade_id, convenio_id) VALUES
('2021-05-20 15:30:00', 200.00, 1, 1, 1, 1),
('2019-09-10 10:00:00', 150.00, 2, 3, 2, 2),
('2020-12-15 08:45:00', 120.00, 3, 5, 3, 1),
('2018-06-07 14:00:00', 100.00, 4, 2, 1, 2),
('2022-03-25 11:30:00', 80.00, 5, 4, 4, 1),
('2017-08-30 16:15:00', 150.00, 1, 3, 2, 1),
('2021-01-05 09:30:00', 180.00, 2, 4, 4, 2),
('2019-07-22 13:45:00', 100.00, 3, 5, 3, 1),
('2020-10-12 11:00:00', 120.00, 5, 2, 1, 2),
('2018-05-03 16:30:00', 80.00, 4, 1, 3, 1);

-- Inclusão de cinco consultas com receituário contendo dois ou mais medicamentos
INSERT INTO consulta (data_consulta, valor, paciente_id, medico_id, especialidade_id, convenio_id) VALUES
('2018-05-15 10:30:00', 150.00, 1, 4, 1, 2),
('2019-08-20 15:45:00', 200.00, 2, 2, 2, 1),
('2020-02-10 09:00:00', 120.00, 3, 5, 1, 2),
('2021-03-05 14:20:00', 180.00, 4, 1, 3, 1),
('2022-06-22 11:10:00', 250.00, 5, 3, 2, 3);

-- Inclusão do receituário com dois ou mais medicamentos para cada consulta
INSERT INTO receita (medicamentos, consulta_id) VALUES
('Dipirona, Amoxicilina', 1),
('Paracetamol, Ibuprofeno, Amoxicilina', 2),
('Dorflex, Dipirona', 3),
('Paracetamol, Ibuprofeno, Nimesulida', 4),
('Cloridrato de Tramadol, Ibuprofeno, Paracetamol', 5),
('Cloridrato de Tramadol, Paracetamol', 5);

-- Inserção de quartos
INSERT INTO quarto (numero, tipo_id) VALUES
(101, 1),
(102, 1),
(201, 2),
(202, 2),
(301, 3);

-- Inserção de dados na tabela enfermeiro
INSERT INTO enfermeiro (nome, cpf, cre) VALUES
("Joana Silva", "12345678901", "12345"),
("Pedro Souza", "23456789012", "23456"),
("Aline Santos", "34567890123", "34567"),
("Rafaela Oliveira", "45678901234", "45678"),
("Gabriel Fernandes", "56789012345", "56789"),
("Julia Rodrigues", "67890123456", "67890");

-- Inserção de dados na tabela internacao
INSERT INTO internacao (data_entrada, data_prevista_alta, data_efetiva_alta, procedimento, medico_id, paciente_id, quarto_id) VALUES
('2022-02-01', '2022-02-10', '2022-02-15', 'Cirurgia de Apendicite', 1, 1, 1),
('2021-07-20', '2021-08-05', '2021-08-10', 'Tratamento de Fratura de Fêmur', 2, 2, 2),
('2018-11-30', '2018-12-10', '2018-12-15', 'Cirurgia de Hérnia Inguinal', 3, 3, 3),
('2019-05-10', '2019-05-20', '2019-05-22', 'Tratamento de Pneumonia', 4, 4, 1),
('2017-06-15', '2017-06-30', '2017-07-05', 'Tratamento de Infecção Urinária', 5, 5, 2),
('2018-09-01', '2018-09-15', '2018-09-18', 'Cirurgia de Apendicite', 6, 6, 3),
('2022-05-01', '2022-05-10', '2022-05-15', 'Tratamento de Fratura de Tornozelo', 1, 2, 1);

-- Inserção de dados na tabela internacao_enfermeiro
INSERT INTO internacao_enfermeiro (internacao_id, enfermeiro_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 2), (2, 4), (2, 5),
(3, 1), (3, 5),
(4, 2), (4, 3),
(5, 3), (5, 4),
(6, 1), (6, 4),
(7, 5), (7, 6);