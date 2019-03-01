--�����༶��
CREATE TABLE banji (
--��������       �ֶ�����     constraINT    Լ������    Լ������
b_id NUMBER                                 CONSTRAINT pk_b_id                         PRIMARY KEY,
b_name VARCHAR2(50)                 CONSTRAINT nn_b_name                  NOT NULL,
b_location VARCHAR2(10)             CONSTRAINT nn_b_location              NOT NULL
);
--��ѯ�û���
SELECT     *                        FROM       User_Tables;
--��ѯԼ����Ϣ
SELECT     *                        FROM       user_constraints;
--����ѧ����
CREATE     TABLE  student    (
s_id  NUMBER(11)  CONSTRAINT  pk_s_id  PRIMARY KEY,--����Լ��
s_name VARCHAR2(12)  CONSTRAINT  nn_s_name  NOT NULL,--�ǿ�Լ��
s_gender  VARCHAR2(6)  DEFAULT  'male'  CONSTRAINT  chk_s_gender  CHECK  (s_gender  IN  ('male','female')),--Ĭ��ֵ�ͼ��Լ��
s_idcard  VARCHAR2(18)  CONSTRAINT  uq_s_idcard  UNIQUE,--ΨһԼ��
s_birthday  DATE  CONSTRAINT  nn_s_birthday  NOT NULL,
s_score  NUMBER(4,1)  DEFAULT  0  CONSTRAINT  chk_s_score  CHECK  (s_score BETWEEN  0  AND  100),--���Լ��
s_banji_id  NUMBER  CONSTRAINT  fk_s_banji_id  REFERENCES banji(b_id)--���Լ��
);

--��ѯ�ƶ����Լ����Ϣ
SELECT  *  FROM  User_Constraints  WHERE  table_name='STUDENT';  

--�½���ʦ��
CREATE  TABLE  teacher (
t_id  NUMBER  PRIMARY  KEY,
t_name VARCHAR2(20)  NOT  NULL,
t_gender  VARCHAR2(6)  DEFAULT 'male' CHECK (t_gender IN ('male','female'))
);


--�����
ALTER TABLE  banji  ADD  b_teacher_id  NUMBER  
--���Լ��
CONSTRAINT fk_b_teacher_id  REFERENCES teacher(t_id);
--teacher�����һ��
ALTER  TABLE  teacher  ADD  t_birthday  DATE;
SELECT  *  FROM  teacher;
--ɾ����
ALTER TABLE banji  DROP  COLUMN  b_teacher_id;
--��༶�����һ��
ALTER  TABLE  banji  ADD  b_teacher_id  NUMBER;
--��������Լ��
ALTER  TABLE  banji  ADD  FOREIGN  KEY(b_teacher_id)
REFERENCES  teacher(t_id);
SELECT  *  FROM  banji;
SELECT  *  FROM  User_Constraints WHERE  Table_Name='BANJI';

--�޸��� alter  table  ����  modify  
--�޸�teacher���е������ֶε���������
ALTER  TABLE  teacher  MODIFY  t_name  VARCHAR2(200);
--�޸�Լ��
ALTER  TABLE  teacher  MODIFY  t_birthday  NOT NULL;
--��ѯ���ϵ�Լ��
SELECT  *  FROM  User_Cons_Columns  WHERE  table_name='TEACHER';
--�޸�Ĭ��ֵ
ALTER  TABLE  teacher  MODIFY  t_gender  DEFAULT  'female';
--�޸�����remame  column 
ALTER  TABLE  teacher  RENAME COLUMN t_name TO  T_name_new;
--����������::rename...to...
RENAME  teacher  TO  TEA;
--ɾ����
CREATE  TABLE  test1(t_id  NUMBER);
DROP TABLE  test1;
--��ϰDDL
CREATE
ALTER  TABLE  table_name (ADD/MODIFY/DROP/RENAME)
DROP
RENAME


