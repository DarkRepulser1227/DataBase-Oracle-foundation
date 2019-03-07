--ģʽ����6�֣�
--��ͼ��ͬ��ʣ����У���������������ʱ��
--1����ͼ��view��
CREATE OR REPLACE VIEW stu_view
AS 
SELECT s_id,s_name,s_math+s_chn+s_eng s_total FROM stu;

SELECT * FROM stu_view;

--�޸���ͼ����
UPDATE stu_view SET s_name='lisi' WHERE s_id=2;
SELECT * FROM stu;
--����ͼ���ݵ���ɾ�ģ�ͬʱҲ�Ƕ�ԭ�����ݵ��޸�
--ɾ����ͼ�еļ�¼
DELETE FROM stu WHERE s_id=3;
SELECT * FROM stu_view;
SELECT * FROM stu;
--�½���ͼ����ѯÿ��ѧ���İ�����
SELECT s_id,s_name,t_name_new 
FROM tea JOIN banji ON banji.T_ID = tea.t_id JOIN stu ON stu.s_banji_id=banji.b_id ORDER BY s_id;
CREATE OR REPLACE VIEW view_tea_stu
AS 
SELECT s_id,s_name,t_name_new 
FROM tea JOIN banji ON banji.T_ID = tea.t_id JOIN stu ON stu.s_banji_id=banji.b_id ORDER BY s_id;

SELECT * FROM view_tea_stu;
-- ��ѯ��ͼ�С������İ�������˭
SELECT * FROM view_tea_stu WHERE s_name='lisi';
--�޶���ͼֻ�����ԣ����ܽ�����ɾ��
CREATE OR REPLACE VIEW view_stu_readonly 
AS 
SELECT s_id,s_name,s_gender FROM stu
WITH READ ONLY;

SELECT * FROM view_stu_readonly;
--�����޸�ֻ����ͼ������
UPDATE view_stu_readonly SET s_name='wangwu' WHERE s_id=4;
--��ѯ��ǰ�û���ͼ
select* FROM USER_VIEWS; 
--ɾ����ͼ
DROP VIEW VIEW_TEA_SUT;
--���ܶ���ͼ������ɾ�ĵ����
--1��ʹ���˾ۺϺ���
--2��ʹ��groupby
--3��ʹ��distinct
--4������rownum�����ֲ��

--2.ͬ���
--Oracle֧�ֶԴ󲿷ֵ�ģʽ���������������Ϊͬ���
CREATE OR REPLACE SYNONYM stu1 FOR stu;
SELECT * FROM stu;
SELECT * FROM stu1;
COMMIT;
--�����ͬ��ʽ������ݵ��޸ģ���Ӱ��ԭ������
UPDATE stu1 SET s_name='wangwu' WHERE s_id=4;
--ɾ��ͬ��� drop
DROP SYNONYM stu1;
--��ͬ�����ص������ֵ�
SELECT * FROM USER_SYNONYMS;

--3.����
--��ѡ�����ã����ֵ����Сֵ����ʼֵ��������������ѭ��������
CREATE SEQUENCE seq_increment
MINVALUE 0
MAXVALUE 999999
START WITH 0
INCREMENT BY 1
NOCACHE
NOCYCLE

CREATE TABLE test_seq(t_id NUMBER PRIMARY KEY);
INSERT INTO test_seq VALUES(seq_increment.NEXTVAL);
SELECT * FROM test_seq;
SELECT * FROM tea;
INSERT INTO tea VALUES(seq_increment.nextval,'ddd','female',to_date('1999-09-09','yyyy-mm-dd'),'','');

--�������йص������ֵ�
SELECT * FROM USER_SEQUENCES;
--ɾ��ͬ����drop

--4.����
--��߲�ѯЧ�� index
CREATE [UNIQUE|bitmap] INDEX INDEX_name
ON table_name (column_name1,column_name2...)
[TABLESPACE tablespace_name
COMPRESS|NOCOMPRESS column_number
LOGGING|NOLOGGING
SORT|NOSORT
REVERSE]
--��������
--1)B-tree������ƽ��������
--ʹ�����1���кܶ�������2���������в�ͬ��ֵ�ܶ࣬3����ѯ�����ݽ�����������м�¼��5%������Ӧ��ȫ��ɨ��

--2��bitmapλͼ����
--�������е��ظ��ܶ�ʱ�������Ա�

--3���������� reverse����b_tree�����ķ���,ʹ�����ݱȽϼ��У�����ѧ�ţ����֤��
SELECT * FROM student;
--4�����ں������������Ժ������߱��ʽ���㣬Ȼ�󽫼������浽������
--5��Ψһ�����ͷ�Ψһ��������������ֵ�ܷ���ͬ��������ΨһԼ������������ж����Զ�����Ψһ����
--6�����������͸�������
--�������������������ʵ��з�ǰ��
--����student���е�s_name�ֶ�b_tree������
--�ȴ�����ռ�
CREATE TABLESPACE test_index DATAFILE 'c:\test_index.ora' SIZE 10m;
CREATE INDEX index_stu_name
ON student(s_name DESC)
TABLESPACE test_index;
--��������ȱ��
--1����߲�ѯЧ��
--ȱ��
--1)ռ�ô��̿ռ�
--2������������ά��������Ҫ��ʱ�����õ�ʱ������������������������
--3����ִ��DML���ʱ�����������������������ά����Ч��

--�ʺ�ʹ�����������
--1��������һ��Ҫ��
--2�������еĲ�ѯƵ��һ��Ҫ��
--3) ���������ļ�¼����̫��
--4������Ҫ��������ϴ�������
--5���ڲ�ѯƵ�ʸߵ�������ϴ�������
--6���ڶ����������ϴ�������
--�����˴�������
--1����Ҫ�ڵڻ��������ϴ�������
--2��Ƶ��������ɾ��
--3��Ҫ���Ʊ��������е�����
--4�������ݱ�������ʱ����Ҫ������

--�޸����� alter
--ɾ������drop
--��������ص������ֵ�
SELECT * FROM USER_INDEXES;




