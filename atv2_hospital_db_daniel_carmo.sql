CREATE DATABASE hospital;
USE hospital;

CREATE TABLE tipo_quarto(
id_tipo INT NOT NULL AUTO_INCREMENT,
descricao  VARCHAR(255),
valor_diaria DECIMAL(9,2) NOT NULL,
PRIMARY KEY (id_tipo)
);

CREATE TABLE quarto(
id_quarto INT NOT NULL AUTO_INCREMENT,
numero INT NOT NULL UNIQUE,
tipo_id INT NOT NULL,
PRIMARY KEY (id_quarto),
FOREIGN KEY (tipo_id) REFERENCES tipo_quarto(id_tipo)
 );
 
 CREATE TABLE convenio(
 id INT NOT NULL AUTO_INCREMENT,
 nome_convenio VARCHAR(45) NOT NULL,
 cnpj VARCHAR(14) NOT NULL UNIQUE,
 carencia DATE,
 carteira_convenio INT,
 PRIMARY KEY (id)
 );
 
 CREATE TABLE paciente(
 id INT NOT NULL AUTO_INCREMENT,
 nome VARCHAR(100) NOT NULL,
 nascimento DATE NOT NULL,
 endereco VARCHAR(255),
 telefone VARCHAR(15),
 email VARCHAR(45),
 cpf VARCHAR(11) NOT NULL UNIQUE,
 rg VARCHAR(20) NOT NULL UNIQUE,
 id_convenio INT,
 PRIMARY KEY (id),
 FOREIGN KEY(id_convenio) REFERENCES convenio(id)
 );
 
 CREATE TABLE medico(
 id INT NOT NULL AUTO_INCREMENT,
 nome VARCHAR(100) NOT NULL,
 crm VARCHAR(20) NOT NULL UNIQUE,
 endereco VARCHAR(255),
 telefone VARCHAR(15),
 email VARCHAR(45),
 PRIMARY KEY (id)
 );
 
 CREATE TABLE especialidade(
 id INT NOT NULL AUTO_INCREMENT,
 especialidade VARCHAR(45) NOT NULL,
 PRIMARY KEY (id)
 );
 
CREATE TABLE medico_especialidade( 
id_medico INT NOT NULL,
id_especialidade INT NOT NULL,
FOREIGN KEY (id_medico) REFERENCES medico(id),
FOREIGN KEY (id_especialidade) REFERENCES especialidade(id)
);

CREATE TABLE consulta(
id INT NOT NULL AUTO_INCREMENT,
data_consulta DATETIME NOT NULL,
valor DECIMAL(9,2) NOT NULL,
paciente_id INT NOT NULL,
medico_id INT NOT NULL,
especialidade_id INT NOT NULL,
convenio_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY(paciente_id) REFERENCES paciente(id),
FOREIGN KEY(medico_id) REFERENCES medico(id),
FOREIGN KEY(especialidade_id) REFERENCES especialidade(id),
FOREIGN KEY(convenio_id) REFERENCES convenio(id)
);

CREATE TABLE receita(
id INT NOT NULL AUTO_INCREMENT,
medicamentos VARCHAR(45) NOT NULL,
consulta_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY(consulta_id) REFERENCES consulta(id)
);

CREATE TABLE internacao(
id INT NOT NULL AUTO_INCREMENT,
data_entrada DATE NOT NULL,
data_prevista_alta DATE,
data_efetiva_alta DATE NOT NULL,
procedimento MEDIUMTEXT NOT NULL,
medico_id INT NOT NULL,
paciente_id INT NOT NULL,
quarto_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY(medico_id) REFERENCES medico(id),
FOREIGN KEY(paciente_id) REFERENCES paciente(id),
FOREIGN KEY(quarto_id) REFERENCES quarto(id_quarto)
);

CREATE TABLE enfermeiro(
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
cpf VARCHAR(11) NOT NULL UNIQUE,
cre VARCHAR(45) NOT NULL UNIQUE,
PRIMARY KEY (id)
);

CREATE TABLE internacao_enfermeiro(
internacao_id INT NOT NULL,
enfermeiro_id INT NOT NULL,
FOREIGN KEY(internacao_id) REFERENCES internacao(id),
FOREIGN KEY(enfermeiro_id) REFERENCES enfermeiro(id)
);