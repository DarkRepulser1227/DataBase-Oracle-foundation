例6.1：创建一个包含所有学生信息的视图。
CREATE VIEW student_view AS SELECT * FROM student;
SELECT s_id, s_name, s_gender, s_nation, s_classname FROM student_view;

例6.2：创建一个供专业课老师查询的学生信息的视图，该视图包括学生的学号、姓名、性别、语种和数语外3科的总成绩信息。
CREATE OR REPLACE VIEW student_view2 AS
SELECT s_id, s_name, s_language, s_chinese + s_math + s_foreign
AS s_totalscore FROM student;
SELECT s_id, s_name, s_language, s_totalscore FROM student_view2;

例6.3：向student_view视图中插入数据。
INSERT INTO student_view VALUES('0807010235', '张三', '男', '汉族', '共青团员', '工商082', '英语', 110, 88, 124, NULL);
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';

例6.4：更新student_view视图中的数据。
UPDATE student_view SET s_name = '李四' WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';

例6.5：删除student_view视图中的数据。
DELETE FROM student_view WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student_view WHERE s_id = '0807010235';
SELECT s_id, s_name, s_foreign FROM student WHERE s_id = '0807010235';

例6.6：删除student_view视图。
DROP VIEW student_view;

例6.7：查询所有学生的学号、姓名等信息，并标识每行的行号
SELECT rownum, s_id, s_name, s_nation, s_classname FROM student;

例6.8：查询student_view2视图的定义信息。
SELECT view_name, text FROM user_views WHERE view_name = 'STUDENT_VIEW2';

例6.9：为学生表创建一个私有同义词。
CREATE OR REPLACE SYNONYM s1 FOR student;

例6.10：为learner用户的学生表创建一个公有同义词。
CREATE OR REPLACE PUBLIC SYNONYM s1 FOR student;

例6.11：删除公有同义词l_student。
DROP PUBLIC SYNONYM l_student;

例6.12：使用user_synonyms视图查看同义词的信息。
SELECT synonym_name, table_owner, table_name, db_link FROM user_synonyms;

例6.13：为论文表的paper _id列定义序列。
CREATE SEQUENCE paper_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 10000000
NOCACHE;

例6.14：使用序列diploma_seq的值作为主键diploma表插入数据。
INSERT INTO diploma VALUES(diploma_seq.NEXTVAL, '专科');

例6.15：为教师表的教师姓名列创建B树索引并将索引创建在test表空间.
create tablespace test datafile 'D:\test.ora' size 100m
CREATE INDEX tname_idx ON teacher(t_name) TABLESPACE test;   

例6.16：为学生表的政治面貌列创建位图索引、为语种列创建反向键索引。
CREATE BITMAP INDEX spolitical_idx ON student(s_political);
CREATE INDEX sforeign_idx ON student(s_foreign) REVERSE;

例6.17：为课程表的课程名称创建函数索引。
CREATE INDEX cname_idx ON course(LOWER(c_name));

例6.18：为学生表的创建函数索引，索引的表达式是语文成绩、数学成绩与外语成绩的和。
CREATE INDEX total_idx ON student(s_chinese + s_math + s_foreign);

例6.19：将索引sforeign_idx由反向键索引改为普通索引，再改为反向键索引。
ALTER INDEX sforeign_idx REBUILD NOREVERSE;                 
ALTER INDEX sforeign_idx REBUILD REVERSE;

例6.20：将索引total_idx重命名为score_idx。
ALTER INDEX total_idx RENAME TO score_idx;

例6.21：使用user_indexes视图查看索引信息。
SELECT index_name, index_type, table_name, uniqueness FROM user_indexes

例6.22：使用user_ind_columns视图查看索引列的信息。
SELECT index_name, table_name, column_name, column_position, descend 
FROM user_ind_columns;

例6.23：创建student_p1表，同时为student_p1表创建3个分区。
CREATE TABLE student_p1(
  s_id VARCHAR2(10) CONSTRAINT pk_student PRIMARY KEY, --学号，主键
  s_name VARCHAR2(20) NOT NULL, --学生姓名
)
PARTITION BY RANGE (s_id)                                 --根据学生的学号分区
(
  PARTITION s_p1 VALUES LESS THAN('0807020104'), 
  PARTITION s_p2 VALUES LESS THAN('0807070117'),
  PARTITION s_p3 VALUES LESS THAN('0807070331')
);

例6.24：向student_p表1中插入数据。
INSERT INTO student_p1 VALUES('0807010101', '张三');
INSERT INTO student_p1 VALUES('0807020104', '李四');
INSERT INTO student_p1 VALUES('0807070331', '王五');
SELECT * FROM student_p1;
SELECT * FROM student_p1 PARTITION(s_p1);
SELECT * FROM student_p1 PARTITION(s_p2);
SELECT * FROM student_p1 PARTITION(s_p3);

例6.25：创建表course_p1，同时为该表创建3个列表分区，分区条件是课程类别。
CREATE TABLE course_p1(
	c_num CHAR(6) NOT NULL,  --课程编号
	c_name VARCHAR2(80) NOT NULL,  --课程名称
	c_type VARCHAR2(30) NOT NULL,  --课程类别
	c_na
	CONSTRAINT pk_course PRIMARY KEY(c_num), --复合主键
)
PARTITION BY LIST (c_type)                      --根据课程类型分区
(
    PARTITION compulsory_course VALUES('学科基础', '专业必修'),
    PARTITION elective_course VALUES('专业限选'),
    PARTITION specialized_course VALUES('专业任选')
);

例6.26：创建course_p2表，同时为该表创建3个哈希分区，分区列是学期。
CREATE TABLE course_p2 (
c_num CHAR(6) NOT NULL,  --课程编号
c_name VARCHAR2(80) NOT NULL,  --课程名称
c_type VARCHAR2(30) NOT NULL,  --课程类别
CONSTRAINT pk_course PRIMARY KEY( c_num), --复合主键

)
PARTITION BY HASH (c_num)                                --根据课程编号分区            
(
  PARTITION c_p1,
  PARTITION c_p2,
  PARTITION c_p3
);

例6.27：为student_p1表添加一个范围分区。
ALTER TABLE student_p1 ADD PARTITION s_p4 VALUES LESS THAN(MAXVALUE);

例6.28：截断course_p1表的elective_course分区。
ALTER TABLE course_p1 TRUNCATE PARTITION elective_course;

例6.29：删除例中student_p1表的s_p4分区。
ALTER TABLE student_p1 DROP PARTITION s_p4;

例6.30：为student_p1表的s_p3分区和 s_p4分区合并。
ALTER TABLE student_p1 MERGE PARTITIONS s_p3, s_p4 INTO PARTITION s_merge;

例6.31：将student_p1表的s_p2分区进行拆分。
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807020104')
INTO (PARTITION s_p3, PARTITION s_p4);
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807070117')
INTO (PARTITION s_p3, PARTITION s_p4);
ALTER TABLE student_p1 SPLIT PARTITION s_p2 AT ('0807050101')
INTO (PARTITION s_p3, PARTITION s_p4);

例6.32：将student_p1表的s_merge分区重命名为s_p5，将teacher_p4表的t_p5子分区重命名为t_p6。
ALTER TABLE student_p1 RENAME PARTITION s_merge TO s_p5;
ALTER TABLE teacher_p4 RENAME SUBPARTITION t_p5 TO t_p6;

例6.33：使用user_part_tables视图查看分区表的信息。
SELECT table_name, partitioning_type, subpartitioning_type, 
partition_count FROM user_part_tables;

例6.34：使用user_tab_partitions视图查看每个分区的具体信息。
SELECT table_name, composite, partition_name, subpartition_count
FROM user_tab_partitions;

例6.35：事务级临时表使用示例。
CREATE GLOBAL TEMPORARY TABLE title_temp(    --这是事务级临时表
title_id NUMBER(2) CONSTRAINT pk_title PRIMARY KEY, --主键
title_name VARCHAR2(50) NOT NULL
);
INSERT INTO title_temp VALUES (1, '教授');
INSERT INTO title_temp VALUES (2, '副教授');
SELECT title_id, title_name FROM title_temp;
--登录到另一个SQL*Plus中执行下面的语句（会话2）
SELECT title_id, title_name FROM title_temp;
--回到原来的SQL*Plus中执行下面的语句（会话1）
COMMIT;                
SELECT title_id, title_name FROM title_temp;

例6.36：会话级临时表使用示例。
CREATE GLOBAL TEMPORARY TABLE diploma_temp(  --这是会话级临时表
diploma_id NUMBER(2) CONSTRAINT pk_diploma PRIMARY KEY, --主键
diploma_name VARCHAR2(20) NOT NULL
) ON COMMIT PRESERVE ROWS;
INSERT INTO diploma_temp VALUES (1, '专科');
INSERT INTO diploma_temp VALUES (2, '本科');
COMMIT;
SELECT diploma_id, diploma_name  FROM diploma_temp;
--登录到另一个SQL*Plus中执行下面的语句（会话2）
SELECT title_id, title_name FROM title_temp;
--退出会话1后重新登录到SQL*Plus中执行下面的语句
SELECT title_id, title_name FROM title_temp;

