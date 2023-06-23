/* Grupo 2 - Mateus Melo Fernandes, Robson Júnior Schultz Dias e Vitor Hugo Burns Lessa.
   CC1Mb 
*/


-- Criar a tabela coordenadores.
CREATE TABLE coordenadores (
                coordenador_id NUMERIC NOT NULL,
                nome           VARCHAR NOT NULL,
                CONSTRAINT coordenadores_pk PRIMARY KEY (coordenador_id)
);

-- Adicionar comentarios para a tabela coordenadores e suas colunas. 
COMMENT ON TABLE  coordenadores                IS 'Tabela que contém informações sobre os coordenadores da uvv.';
COMMENT ON COLUMN coordenadores.coordenador_id IS 'Número de identificação do coordenador.';
COMMENT ON COLUMN coordenadores.nome           IS 'Nome do coordenador.';

-- Adicionar as check constraints da tabela coordenadores.
ALTER TABLE coordenadores
ADD CONSTRAINT coordenador_id_positivo
CHECK (
    coordenador_id > 0
);

-- Criar a tabela alunos.
CREATE TABLE alunos (
                matricula NUMERIC NOT NULL,
                curso     VARCHAR NOT NULL,
                turma     VARCHAR NOT NULL,
                nome      VARCHAR NOT NULL,
                CONSTRAINT alunos_pk PRIMARY KEY (matricula)
);

-- Adicionar comentarios para a tabela alunos e suas colunas. 
COMMENT ON TABLE  alunos           IS 'Tabela que contém informações sobre os alunos da uvv.';
COMMENT ON COLUMN alunos.matricula IS 'Matrícula do aluno, utilizado como número de identificação.';
COMMENT ON COLUMN alunos.curso     IS 'Curso do aluno.';
COMMENT ON COLUMN alunos.turma     IS 'Turma do aluno';
COMMENT ON COLUMN alunos.nome      IS 'Nome do aluno.';

-- Adicionar as check constraints da tabela alunos.
ALTER TABLE alunos
ADD CONSTRAINT matricula_positiva
CHECK (
    matricula > 0
);


-- Criar a tabela certificados.
CREATE TABLE certificados (
                certificado_id NUMERIC NOT NULL,
                data_envio     DATE    NOT NULL,
                situacao       VARCHAR NOT NULL,
                matricula      NUMERIC NOT NULL,
                coordenador_id NUMERIC NOT NULL,
                CONSTRAINT certificados_pk PRIMARY KEY (certificado_id)
);

-- Adicionar comentarios para a tabela certificados e suas colunas. 
COMMENT ON TABLE  certificados                IS 'Tabela que contém informações sobre os certificados de horas extras.';
COMMENT ON COLUMN certificados.certificado_id IS 'Número de identificação do certificado.';
COMMENT ON COLUMN certificados.data_envio     IS 'Data em que foi enviado o certificado';
COMMENT ON COLUMN certificados.situacao       IS 'Situação do certificado. Valores aceitos: "Em análise", "Aprovado" e "Reprovado".';
COMMENT ON COLUMN certificados.matricula      IS 'FK que indica a qual aluno pertence o certificado.';
COMMENT ON COLUMN certificados.coordenador_id IS 'FK que indica o coordenador que corrigiu o certificado.';

-- Adicionar as check constraints da tabela certificados.
ALTER TABLE certificados
ADD CONSTRAINT situacao_valores
CHECK (
    situacao IN ('EM ANÁLISE', 'APROVADO', 'REPROVADO')
);

ALTER TABLE certificados
ADD CONSTRAINT certificado_id_positivo
CHECK (
    certificado_id > 0
);

ALTER TABLE certificados ADD CONSTRAINT coordenadores_certificados_fk
FOREIGN KEY (coordenador_id)
REFERENCES coordenadores (coordenador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE certificados ADD CONSTRAINT alunos_certificados_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;