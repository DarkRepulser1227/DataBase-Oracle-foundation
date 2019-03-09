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

--5.��������һ����������ı�ֳ����ɽ�С�ģ����Զ�������ķ�������߲�ѯ�ʹ洢Ч�ʡ��ڴ������ʱ�򣬾�Ҫָ����������
--����������
--1����Χ������Range��less than��
CREATE TABLE student1 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_score NUMBER(4,1))
PARTITION BY RANGE(s_score)(
PARTITION  par_student1_1 VALUES LESS THAN (60),
PARTITION par_student1_2 VALUES LESS THAN(80),
PARTITION par_student1_3 VALUES LESS THAN(100)
); 
SELECT * FROM student1;
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'a',59);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'b',69);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'c',79);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'d',89);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'e',99);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'f',20);
INSERT INTO student1 VALUES(SEQ_INCREMENT.nextval,'g',73);
COMMIT;
SELECT * FROM student1 WHERE s_score>=60;
SELECT * FROM student1 PARTITION(par_student1_1);
SELECT * FROM student1 PARTITION(par_student1_2);
SELECT * FROM student1 PARTITION(par_student1_3);

SELECT * FROM student1 PARTITION(par_student1_1) WHERE s_score<40;

--2�����������Interval��
--����ְʱ��Ϊ2006��1��1��֮ǰ����ʦ�ŵ��˵�һ����
--��2010��1��1��֮ǰ�ķ��ڵڶ�������
--�˺���ְ���ˣ���������ϵͳ����
CREATE TABLE teacher1 (t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32),t_entertime DATE)
PARTITION BY RANGE(t_entertime)
INTERVAL (NUMTOYMINTERVAL (1,'MONTH'))(
PARTITION par_teacher1_1 VALUES LESS THAN(DATE '2006-1-1'),
PARTITION par_teacher1_2 VALUES LESS THAN(DATE '2010-1-1')
);


SELECT * FROM teacher1;
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2005-4-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2006-4-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2008-4-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2009-4-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2010-3-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2011-4-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2011-5-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2011-10-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2012-1-4','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2012-1-14','yyyy-mm-dd'));
INSERT INTO teacher1 VALUES(SEQ_INCREMENT.nextval,'1',to_date('2012-3-14','yyyy-mm-dd'));
--��ѯ��ǰ���������Ϣ
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='TEACHER1';
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
SELECT * FROM teacher1 PARTITION(par_teacher1_2);
SELECT * FROM teacher1 PARTITION(sys_p21);
SELECT * FROM teacher1 PARTITION(sys_p22);
SELECT * FROM teacher1 PARTITION(sys_p23);
SELECT * FROM teacher1 PARTITION(sys_p24);
SELECT * FROM teacher1 PARTITION(sys_p25);
SELECT * FROM teacher1 PARTITION(sys_p26);
--��ѧ���ɼ��������Ϊ��һ�������������ɼ���ÿ10��Ϊһ��
CREATE TABLE student2 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_score NUMBER(4,1))
PARTITION BY RANGE(s_score)
INTERVAL(10)(
PARTITION par_student2 VALUES LESS THAN(60)
);

INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'a',59);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'a',60);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'b',69);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'c',79);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'d',89);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'e',99);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'f',20);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'g',73);
INSERT INTO student2 VALUES(SEQ_INCREMENT.nextval,'g',100);
SELECT * FROM student2 ORDER BY s_score;
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='STUDENT2';
SELECT * FROM student2 PARTITION(par_student2);
SELECT * FROM student2 PARTITION(sys_p27);
SELECT * FROM student2 PARTITION(sys_p28);
SELECT * FROM student2 PARTITION(sys_p29);
SELECT * FROM student2 PARTITION(sys_p30);
SELECT * FROM student2 PARTITION(sys_p31);

--���������ע������
--1.��������ɷ�Χ������������
--2.ָ���������޶�����
--3.������date����ʱnumber
--4.����Ҫָ��һ�����÷���

--3.�б������list��
--��ѧ�������Ա����
CREATE TABLE student3 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_gender VARCHAR2(32))
PARTITION BY LIST(s_gender)(
PARTITION par_student3_1 VALUES('male'),
PARTITION par_student3_2 VALUES('female')
)

INSERT INTO student3 VALUES(SEQ_INCREMENT.nextval,'a','male');
INSERT INTO student3 VALUES(SEQ_INCREMENT.nextval,'a','female');
INSERT INTO student3 VALUES(SEQ_INCREMENT.nextval,'a','male');
INSERT INTO student3 VALUES(SEQ_INCREMENT.nextval,'a','female');
INSERT INTO student3 VALUES(SEQ_INCREMENT.nextval,'a','male');
COMMIT;

SELECT * FROM student3;
SELECT * FROM student3 PARTITION(par_student3_1);
SELECT * FROM student3 PARTITION(par_student3_2);


CREATE TABLE student4 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_gender VARCHAR2(32))
PARTITION BY LIST(s_gender)(
PARTITION par_student4_1 VALUES('male'),
PARTITION par_student4_2 VALUES('female'),
PARTITION par_student4_3 VALUES('δ֪','��ȷ��','����')
)
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','male');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','female');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','δ֪');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','����');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','��ȷ��');
COMMIT;

SELECT * FROM student4;
SELECT * FROM student4 PARTITION(par_student4_1);
SELECT * FROM student4 PARTITION(par_student4_2);
SELECT * FROM student4 PARTITION(par_student4_3);

--��ϣ������hash����ͨ����ϣ�㷨
CREATE TABLE student5 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_gender VARCHAR2(32))
PARTITION BY HASH(s_name)(
PARTITION par_student5_1,
PARTITION par_student5_2,
PARTITION par_student5_3
);
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'aoutrhjt','male');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'��ŷ̫','female');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'��Ŷ','δ֪');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'��˹','����');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'����','��ȷ��');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'����','δ֪');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'����','����');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'ѩ�ܾ�','��ȷ��');


SELECT * FROM student5;
SELECT * FROM student5 PARTITION(par_student5_1);
SELECT * FROM student5 PARTITION(par_student5_2);
SELECT * FROM student5 PARTITION(par_student5_3);

--5.���÷�����Reference��
DROP TABLE city;
CREATE TABLE city(c_id NUMBER PRIMARY KEY,c_name VARCHAR2(32))
PARTITION BY LIST(c_id)(
PARTITION par_city_1 VALUES(1),
PARTITION par_city_2 VALUES(2),
PARTITION par_city_3 VALUES(3)
);
INSERT INTO city VALUES(1,'���');
INSERT INTO city VALUES(2,'����');
INSERT INTO city VALUES(3,'�Ϻ�');
COMMIT;

SELECT * FROM city PARTITION(par_city_1);
SELECT * FROM city PARTITION(par_city_2);
SELECT * FROM city PARTITION(par_city_3);

--�������ñ�
--ע������1.�������ֶα���ʱ�����У�2.�������в���Ϊnull,3 ���������Լ��������Ϊ����������4.���ñ�ͱ����ñ��ķ�������һ��

CREATE TABLE emp (e_id NUMBER PRIMARY KEY,e_name VARCHAR2(32),e_city_id NUMBER CONSTRAINT fk_city REFERENCES city(c_id) NOT NULL)
PARTITION BY REFERENCE(fk_city);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',1);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',3);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',3);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',2);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',1);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',2);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',1);
INSERT INTO emp VALUES(SEQ_INCREMENT.nextval,'a',2);
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='EMP';
SELECT * FROM emp PARTITION(par_city_1);
SELECT * FROM emp PARTITION(par_city_2);
SELECT * FROM emp PARTITION(par_city_3);

--6.ϵͳ����(system)
--����5�з��������ʺϣ���������Ҫ����
--����Ҫָ��������������insert����ָ��Ҫ����ķ���
CREATE TABLE student6 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32))
PARTITION BY SYSTEM(
PARTITION par_student6_1,
PARTITION par_student6_2
);


INSERT INTO student6 PARTITION(par_student6_1) VALUES(SEQ_INCREMENT.nextval,'a');
INSERT INTO student6 PARTITION(par_student6_2) VALUES(SEQ_INCREMENT.nextval,'b');
INSERT INTO student6 PARTITION(par_student6_2) VALUES(SEQ_INCREMENT.nextval,'c');

SELECT * FROM student6 PARTITION(par_student6_1);
SELECT * FROM student6 PARTITION(par_student6_2);

--�Է������еĲ���

--1.�ͷ�����ص������ֵ�
--��ѯ��ķ�������
SELECT * FROM USER_PART_TABLES WHERE table_name='STUDENT1';
--2.����һ��������add�������ڷ�Χ���������������һ������֮������·���
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 ADD PARTITION par_student1_4 VALUES LESS THAN (120);
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 ADD PARTITION par_student1_4 VALUES LESS THAN (70);
--3.�ضϷ�����trancate����ɾ�����������ݣ����Ƿ�����ɾ��
SELECT * FROM teacher1;
SELECT * FROM user_tab_partitions WHERE table_name='TEACHER1'
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
ALTER TABLE teacher1 TRUNCATE PARTITION par_teacher1_1;
--4.ɾ������(drop)��ɾ�����ݣ�����ͬʱҲ��ɾ��
--hash���������÷�������ɾ����������������ɾ�����һ������,�����������ɾ�����һ������
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
ALTER TABLE teacher1 DROP PARTITION par_teacher1_1;
--5.��ַ���(split)
--1).���ڷ�Χ�������ؼ���Ϊat
--���student1���60-9-80�ķ���������60-70��70-80
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
SELECT * FROM student1 PARTITION (PAR_STUDENT1_2);
ALTER TABLE student1 SPLIT PARTITION PAR_STUDENT1_2 AT(70) INTO(PARTITION PAR_STUDENT1_11,PARTITION PAR_STUDENT1_12);
SELECT * FROM student1 PARTITION (PAR_STUDENT1_11);
SELECT * FROM student1 PARTITION (PAR_STUDENT1_12);
--2)�����б����
SELECT * FROM student4;
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='STUDENT4';
--��ֵ���������
SELECT * FROM student4 PARTITION(PAR_STUDENT4_3);
ALTER TABLE student4 SPLIT PARTITION PAR_STUDENT4_3 VALUES('��ȷ��') INTO (PARTITION PAR_STUDENT4_11,PARTITION PAR_STUDENT4_12);
SELECT * FROM student4 PARTITION(PAR_STUDENT4_11);
SELECT * FROM student4 PARTITION(PAR_STUDENT4_12);
--6.�ϲ����� ��merge��
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 MERGE PARTITIONS PAR_STUDENT1_11,PAR_STUDENT1_12 INTO PARTITION PAR_STUDENT1_99;
SELECT * FROM student1 PARTITION (PAR_STUDENT1_99);
--7.��������������rename to��
ALTER  TABLE student1 RENAME PARTITION PAR_STUDENT1_99 TO PAR_STUDENT1_2;
SELECT * FROM student1 PARTITION (PAR_STUDENT1_2);

--6.��ʱ����һ���Ự���ɼ��������ڲ���
--��Ϊ�Ự��������,�Ự����ʱ���Ự����ʱ��������գ�������ʱ���������ύʱ���������
--�Ự����ʱ��
CREATE GLOBAL TEMPORARY TABLE temp1(t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32)) ON COMMIT PRESERVE ROWS;
INSERT INTO temp1 VALUES(1,'aaa');
COMMIT;
SELECT * FROM temp1;
--������ʱ��,����ֻ�����ύ֮ǰ������һ���ύ�����ݾͱ����
CREATE GLOBAL TEMPORARY TABLE temp3(t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32)) ON COMMIT DELETE ROWS;
INSERT INTO temp3 VALUES(2,'aaa');
COMMIT;
SELECT * FROM temp3;
INSERT INTO temp3 VALUES(2,'aaa');
COMMIT;
--ɾ����ʱ��
DROP TABLE table_name;
