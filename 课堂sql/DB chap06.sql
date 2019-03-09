��6.1������һ����������ѧ����Ϣ����ͼ��
CREATE VIEW student_view AS SELECT * FROM student;
SELECT s_id, s_name, s_gender, s_nation, s_classname FROM student_view;

��6.2������һ����רҵ����ʦ��ѯ��ѧ����Ϣ����ͼ������ͼ����ѧ����ѧ�š��������Ա����ֺ�������3�Ƶ��ܳɼ���Ϣ��
CREATE OR REPLACE VIEW student_view2 AS
SELECT s_id, s_name, s_language, s_chinese + s_math + s_foreign
AS s_totalscore FROM student;
SELECT s_id, s_name, s_language, s_totalscore FROM student_view2;

��6.3����student_view��ͼ�в������ݡ�
INSERT INTO student_view VALUES('0807010235', '����', '��', '����', '������Ա', '����082', 'Ӣ��', 110, 88, 124, NULL);
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';

��6.4������student_view��ͼ�е����ݡ�
UPDATE student_view SET s_name = '����' WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';

��6.5��ɾ��student_view��ͼ�е����ݡ�
DELETE FROM student_view WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';

��6.6��ɾ��student_view��ͼ��
DROP VIEW student_view;

��6.7����ѯ����ѧ����ѧ�š���������Ϣ������ʶÿ�е��к�
SELECT rownum, s_id, s_name, s_nation, s_classname FROM student;

��6.8����ѯstudent_view2��ͼ�Ķ�����Ϣ��
SELECT view_name, text FROM user_views WHERE view_name = 'STUDENT_VIEW2';

��6.9��Ϊѧ������һ��˽��ͬ��ʡ�
CREATE OR REPLACE SYNONYM s1 FOR student;

��6.10��Ϊlearner�û���ѧ������һ������ͬ��ʡ�
CREATE OR REPLACE PUBLIC SYNONYM s1 FOR student;

��6.11��ɾ������ͬ���l_student��
DROP PUBLIC SYNONYM l_student;

��6.12��ʹ��user_synonyms��ͼ�鿴ͬ��ʵ���Ϣ��
SELECT synonym_name, table_owner, table_name, db_link FROM user_synonyms;

��6.13��Ϊ���ı��paper _id�ж������С�
CREATE SEQUENCE paper_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 10000000
NOCACHE;

��6.14��ʹ������diploma_seq��ֵ��Ϊ����diploma��������ݡ�
INSERT INTO diploma VALUES(diploma_seq.NEXTVAL, 'ר��');

��6.15��Ϊ��ʦ��Ľ�ʦ�����д���B��������������������test��ռ�.
create tablespace test datafile 'D:\test.ora' size 100m
CREATE INDEX tname_idx ON teacher(t_name) TABLESPACE test;   

��6.16��Ϊѧ�����������ò�д���λͼ������Ϊ�����д��������������
CREATE BITMAP INDEX spolitical_idx ON student(s_political);
CREATE INDEX sforeign_idx ON student(s_foreign) REVERSE;

��6.17��Ϊ�γ̱�Ŀγ����ƴ�������������
CREATE INDEX cname_idx ON course(LOWER(c_name));

��6.18��Ϊѧ����Ĵ������������������ı��ʽ�����ĳɼ�����ѧ�ɼ�������ɼ��ĺ͡�
CREATE INDEX total_idx ON student(s_chinese + s_math + s_foreign);

��6.19��������sforeign_idx�ɷ����������Ϊ��ͨ�������ٸ�Ϊ�����������
ALTER INDEX sforeign_idx REBUILD NOREVERSE;                 
ALTER INDEX sforeign_idx REBUILD REVERSE;

��6.20��������total_idx������Ϊscore_idx��
ALTER INDEX total_idx RENAME TO score_idx;

��6.21��ʹ��user_indexes��ͼ�鿴������Ϣ��
SELECT index_name, index_type, table_name, uniqueness FROM user_indexes

��6.22��ʹ��user_ind_columns��ͼ�鿴�����е���Ϣ��
SELECT index_name, table_name, column_name, column_position, descend 
FROM user_ind_columns;

��6.23������student_p1��ͬʱΪstudent_p1����3��������
CREATE TABLE student_p1(
  s_id VARCHAR2(10) CONSTRAINT pk_student PRIMARY KEY, --ѧ�ţ�����
  s_name VARCHAR2(20) NOT NULL, --ѧ������
)
PARTITION BY RANGE (s_id)                                 --����ѧ����ѧ�ŷ���
(
  PARTITION s_p1 VALUES LESS THAN('0807020104'), 
  PARTITION s_p2 VALUES LESS THAN('0807070117'),
  PARTITION s_p3 VALUES LESS THAN('0807070331')
);

��6.24����student_p��1�в������ݡ�
INSERT INTO student_p1 VALUES('0807010101', '����');
INSERT INTO student_p1 VALUES('0807020104', '����');
INSERT INTO student_p1 VALUES('0807070331', '����');
SELECT * FROM student_p1;
SELECT * FROM student_p1 PARTITION(s_p1);
SELECT * FROM student_p1 PARTITION(s_p2);
SELECT * FROM student_p1 PARTITION(s_p3);

��6.25��������course_p1��ͬʱΪ�ñ���3���б���������������ǿγ����
CREATE TABLE course_p1(
	c_num CHAR(6) NOT NULL,  --�γ̱��
	c_name VARCHAR2(80) NOT NULL,  --�γ�����
	c_type VARCHAR2(30) NOT NULL,  --�γ����
	c_na
	CONSTRAINT pk_course PRIMARY KEY(c_num), --��������
)
PARTITION BY LIST (c_type)                      --���ݿγ����ͷ���
(
    PARTITION compulsory_course VALUES('ѧ�ƻ���', 'רҵ����'),
    PARTITION elective_course VALUES('רҵ��ѡ'),
    PARTITION specialized_course VALUES('רҵ��ѡ')
);

��6.26������course_p2��ͬʱΪ�ñ���3����ϣ��������������ѧ�ڡ�
CREATE TABLE course_p2 (
c_num CHAR(6) NOT NULL,  --�γ̱��
c_name VARCHAR2(80) NOT NULL,  --�γ�����
c_type VARCHAR2(30) NOT NULL,  --�γ����
CONSTRAINT pk_course PRIMARY KEY( c_num), --��������

)
PARTITION BY HASH (c_num)                                --���ݿγ̱�ŷ���            
(
  PARTITION c_p1,
  PARTITION c_p2,
  PARTITION c_p3
);

��6.27��Ϊstudent_p1�����һ����Χ������
ALTER TABLE student_p1 ADD PARTITION s_p4 VALUES LESS THAN(MAXVALUE);

��6.28���ض�course_p1���elective_course������
ALTER TABLE course_p1 TRUNCATE PARTITION elective_course;

��6.29��ɾ������student_p1���s_p4������
ALTER TABLE student_p1 DROP PARTITION s_p4;

��6.30��Ϊstudent_p1���s_p3������ s_p4�����ϲ���
ALTER TABLE student_p1 MERGE PARTITIONS s_p3, s_p4 INTO PARTITION s_merge;

��6.31����student_p1���s_p2�������в�֡�
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807020104')
INTO (PARTITION s_p3, PARTITION s_p4);
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807070117')
INTO (PARTITION s_p3, PARTITION s_p4);
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807050101')
INTO (PARTITION s_p3, PARTITION s_p4);

��6.32����student_p1���s_merge����������Ϊs_p5����teacher_p4���t_p5�ӷ���������Ϊt_p6��
ALTER TABLE student_p1 RENAME PARTITION s_merge TO s_p5;
ALTER TABLE teacher_p4 RENAME SUBPARTITION t_p5 TO t_p6;

��6.33��ʹ��user_part_tables��ͼ�鿴���������Ϣ��
SELECT table_name, partitioning_type, subpartitioning_type, 
partition_count FROM user_part_tables;

��6.34��ʹ��user_tab_partitions��ͼ�鿴ÿ�������ľ�����Ϣ��
SELECT table_name, composite, partition_name, subpartition_count
FROM user_tab_partitions;

��6.35��������ʱ��ʹ��ʾ����
CREATE GLOBAL TEMPORARY TABLE title_temp(    --����������ʱ��
title_id NUMBER(2) CONSTRAINT pk_title PRIMARY KEY, --����
title_name VARCHAR2(50) NOT NULL
);
INSERT INTO title_temp VALUES (1, '����');
INSERT INTO title_temp VALUES (2, '������');
SELECT title_id, title_name FROM title_temp;
--��¼����һ��SQL*Plus��ִ���������䣨�Ự2��
SELECT title_id, title_name FROM title_temp;
--�ص�ԭ����SQL*Plus��ִ���������䣨�Ự1��
COMMIT;                
SELECT title_id, title_name FROM title_temp;

��6.36���Ự����ʱ��ʹ��ʾ����
CREATE GLOBAL TEMPORARY TABLE diploma_temp(  --���ǻỰ����ʱ��
diploma_id NUMBER(2) CONSTRAINT pk_diploma PRIMARY KEY, --����
diploma_name VARCHAR2(20) NOT NULL
) ON COMMIT PRESERVE ROWS;
INSERT INTO diploma_temp VALUES (1, 'ר��');
INSERT INTO diploma_temp VALUES (2, '����');
COMMIT;
SELECT diploma_id, diploma_name  FROM diploma_temp;
--��¼����һ��SQL*Plus��ִ���������䣨�Ự2��
SELECT title_id, title_name FROM title_temp;
--�˳��Ự1�����µ�¼��SQL*Plus��ִ����������
SELECT title_id, title_name FROM title_temp;

