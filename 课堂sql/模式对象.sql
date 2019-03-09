--模式对象（6种）
--视图，同义词，序列，索引，分区，临时表
--1。视图（view）
CREATE OR REPLACE VIEW stu_view
AS 
SELECT s_id,s_name,s_math+s_chn+s_eng s_total FROM stu;

SELECT * FROM stu_view;

--修改视图数据
UPDATE stu_view SET s_name='lisi' WHERE s_id=2;
SELECT * FROM stu;
--对视图数据的增删改，同时也是对原表数据的修改
--删除视图中的记录
DELETE FROM stu WHERE s_id=3;
SELECT * FROM stu_view;
SELECT * FROM stu;
--新建视图，查询每个学生的班主任
SELECT s_id,s_name,t_name_new 
FROM tea JOIN banji ON banji.T_ID = tea.t_id JOIN stu ON stu.s_banji_id=banji.b_id ORDER BY s_id;
CREATE OR REPLACE VIEW view_tea_stu
AS 
SELECT s_id,s_name,t_name_new 
FROM tea JOIN banji ON banji.T_ID = tea.t_id JOIN stu ON stu.s_banji_id=banji.b_id ORDER BY s_id;

SELECT * FROM view_tea_stu;
-- 查询视图中。张三的班主任是谁
SELECT * FROM view_tea_stu WHERE s_name='lisi';
--限定视图只读属性，不能进行增删改
CREATE OR REPLACE VIEW view_stu_readonly 
AS 
SELECT s_id,s_name,s_gender FROM stu
WITH READ ONLY;

SELECT * FROM view_stu_readonly;
--尝试修改只读视图的数据
UPDATE view_stu_readonly SET s_name='wangwu' WHERE s_id=4;
--查询当前用户视图
select* FROM USER_VIEWS; 
--删除视图
DROP VIEW VIEW_TEA_SUT;
--不能对视图进行增删改的情况
--1）使用了聚合函数
--2）使用groupby
--3）使用distinct
--4）出现rownum，出现并差交

--2.同义词
--Oracle支持对大部分的模式对象起个别名，称为同义词
CREATE OR REPLACE SYNONYM stu1 FOR stu;
SELECT * FROM stu;
SELECT * FROM stu1;
COMMIT;
--如果对同义词进行数据的修改，会影响原表数据
UPDATE stu1 SET s_name='wangwu' WHERE s_id=4;
--删除同义词 drop
DROP SYNONYM stu1;
--和同义词相关的数据字典
SELECT * FROM USER_SYNONYMS;

--3.序列
--可选的设置，最大值，最小值，起始值，步长，增减，循环，缓存
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

--和序列有关的数据字典
SELECT * FROM USER_SEQUENCES;
--删除同样是drop

--4.索引
--提高查询效率 index
CREATE [UNIQUE|bitmap] INDEX INDEX_name
ON table_name (column_name1,column_name2...)
[TABLESPACE tablespace_name
COMPRESS|NOCOMPRESS column_number
LOGGING|NOLOGGING
SORT|NOSORT
REVERSE]
--索引类型
--1)B-tree索引，平衡树索引
--使用情况1，行很多的情况，2，索引列中不同的值很多，3，查询的数据结果不超过所有记录的5%，否则应该全表扫描

--2）bitmap位图索引
--当索引列的重复很多时，比如性别

--3）反向索引 reverse，对b_tree索引的反向,使用数据比较集中，比如学号，身份证号
SELECT * FROM student;
--4）基于函数的索引，对函数或者表达式计算，然后将计算结果存到索引中
--5）唯一索引和非唯一索引，根据索引值能否相同，主键和唯一约束和外键所在列都会自动创建唯一索引
--6）单列索引和复合索引
--符合索引，经常被访问的列放前面
--创建student表中的s_name字段b_tree索引，
--先创建表空间
CREATE TABLESPACE test_index DATAFILE 'c:\test_index.ora' SIZE 10m;
CREATE INDEX index_stu_name
ON student(s_name DESC)
TABLESPACE test_index;
--索引的优缺点
--1）提高查询效率
--缺点
--1)占用磁盘空间
--2）创建索引和维护索引都要耗时，耗用的时间随着数据量的增长和整张
--3）当执行DML语句时，都会更新索引，降低数据维护的效率

--适合使用索引的情况
--1）数据量一定要大
--2）索引列的查询频率一定要高
--3) 满足条件的记录不能太多
--4）在需要排序的列上创建索引
--5）在查询频率高的组合列上创建索引
--6）在多表的连捷列上创建索引
--不适宜创建索引
--1）不要在第基数的列上创建索引
--2）频繁进行增删改
--3）要限制表上索引列的数量
--4）向数据表导入数据时，不要建索引

--修改索引 alter
--删除索引drop
--和索引相关的数据字典
SELECT * FROM USER_INDEXES;

--5.分区，将一个数据量大的表分成若干较小的，可以独立管理的分区，提高查询和存储效率。在创建表的时候，就要指明分区规则
--分区的种类
--1）范围分区（Range，less than）
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

--2）间隔分区（Interval）
--将入职时间为2006年1月1号之前的老师放到了第一分区
--将2010年1月1号之前的放在第二个分区
--此后入职的人，按月生成系统分区
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
--查询当前表的区分信息
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='TEACHER1';
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
SELECT * FROM teacher1 PARTITION(par_teacher1_2);
SELECT * FROM teacher1 PARTITION(sys_p21);
SELECT * FROM teacher1 PARTITION(sys_p22);
SELECT * FROM teacher1 PARTITION(sys_p23);
SELECT * FROM teacher1 PARTITION(sys_p24);
SELECT * FROM teacher1 PARTITION(sys_p25);
SELECT * FROM teacher1 PARTITION(sys_p26);
--将学生成绩不及格的为第一个分区，其他成绩，每10分为一档
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

--间隔分区的注意事项
--1.间隔分区由范围分区派生而来
--2.指定长度来限定分区
--3.适用于date或者时number
--4.至少要指定一个永久分区

--3.列表分区（list）
--将学生按照性别分区
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
PARTITION par_student4_3 VALUES('未知','不确定','其他')
)
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','male');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','female');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','未知');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','其他');
INSERT INTO student4 VALUES(SEQ_INCREMENT.nextval,'a','不确定');
COMMIT;

SELECT * FROM student4;
SELECT * FROM student4 PARTITION(par_student4_1);
SELECT * FROM student4 PARTITION(par_student4_2);
SELECT * FROM student4 PARTITION(par_student4_3);

--哈希分区（hash），通过哈希算法
CREATE TABLE student5 (s_id NUMBER PRIMARY KEY,s_name VARCHAR2(32),s_gender VARCHAR2(32))
PARTITION BY HASH(s_name)(
PARTITION par_student5_1,
PARTITION par_student5_2,
PARTITION par_student5_3
);
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'aoutrhjt','male');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'俄欧太','female');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'张哦','未知');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'里斯','其他');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'王五','不确定');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'赵六','未知');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'破天','其他');
INSERT INTO student5 VALUES(SEQ_INCREMENT.nextval,'雪拒绝','不确定');


SELECT * FROM student5;
SELECT * FROM student5 PARTITION(par_student5_1);
SELECT * FROM student5 PARTITION(par_student5_2);
SELECT * FROM student5 PARTITION(par_student5_3);

--5.引用分区（Reference）
DROP TABLE city;
CREATE TABLE city(c_id NUMBER PRIMARY KEY,c_name VARCHAR2(32))
PARTITION BY LIST(c_id)(
PARTITION par_city_1 VALUES(1),
PARTITION par_city_2 VALUES(2),
PARTITION par_city_3 VALUES(3)
);
INSERT INTO city VALUES(1,'天津');
INSERT INTO city VALUES(2,'北京');
INSERT INTO city VALUES(3,'上海');
COMMIT;

SELECT * FROM city PARTITION(par_city_1);
SELECT * FROM city PARTITION(par_city_2);
SELECT * FROM city PARTITION(par_city_3);

--创建引用表
--注意事项1.分区的字段必须时引用列，2.被引用列不能为null,3 分区是外键约束名称作为区分条件，4.引用表和被引用报的分区名称一样

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

--6.系统分区(system)
--上面5中分区都不适合，而且又需要分区
--不需要指明分区条件，在insert语句里，指明要插入的分区
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

--对分区进行的操作

--1.和分区相关的数据字典
--查询表的分区类型
SELECT * FROM USER_PART_TABLES WHERE table_name='STUDENT1';
--2.加添一个分区（add）：对于范围分区，智能在最后一个分区之后添加新分区
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 ADD PARTITION par_student1_4 VALUES LESS THAN (120);
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 ADD PARTITION par_student1_4 VALUES LESS THAN (70);
--3.截断分区（trancate）：删除分区中数据，但是分区不删除
SELECT * FROM teacher1;
SELECT * FROM user_tab_partitions WHERE table_name='TEACHER1'
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
ALTER TABLE teacher1 TRUNCATE PARTITION par_teacher1_1;
--4.删除分区(drop)，删除数据，分区同时也被删除
--hash合区和引用分区不能删除，其他分区不能删除最后一个分区,间隔分区不能删除最后一个分区
SELECT * FROM teacher1 PARTITION(par_teacher1_1);
ALTER TABLE teacher1 DROP PARTITION par_teacher1_1;
--5.拆分分区(split)
--1).对于范围分区，关键字为at
--拆分student1表的60-9-80的分区，其中60-70，70-80
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
SELECT * FROM student1 PARTITION (PAR_STUDENT1_2);
ALTER TABLE student1 SPLIT PARTITION PAR_STUDENT1_2 AT(70) INTO(PARTITION PAR_STUDENT1_11,PARTITION PAR_STUDENT1_12);
SELECT * FROM student1 PARTITION (PAR_STUDENT1_11);
SELECT * FROM student1 PARTITION (PAR_STUDENT1_12);
--2)对于列表分区
SELECT * FROM student4;
SELECT * FROM USER_TAB_PARTITIONS WHERE table_name='STUDENT4';
--拆分第三个分区
SELECT * FROM student4 PARTITION(PAR_STUDENT4_3);
ALTER TABLE student4 SPLIT PARTITION PAR_STUDENT4_3 VALUES('不确定') INTO (PARTITION PAR_STUDENT4_11,PARTITION PAR_STUDENT4_12);
SELECT * FROM student4 PARTITION(PAR_STUDENT4_11);
SELECT * FROM student4 PARTITION(PAR_STUDENT4_12);
--6.合并分区 （merge）
SELECT * FROM user_tab_partitions WHERE table_name='STUDENT1'
ALTER TABLE student1 MERGE PARTITIONS PAR_STUDENT1_11,PAR_STUDENT1_12 INTO PARTITION PAR_STUDENT1_99;
SELECT * FROM student1 PARTITION (PAR_STUDENT1_99);
--7.分区的重命名（rename to）
ALTER  TABLE student1 RENAME PARTITION PAR_STUDENT1_99 TO PAR_STUDENT1_2;
SELECT * FROM student1 PARTITION (PAR_STUDENT1_2);

--6.临时表，另一个会话不可见，不存在并发
--分为会话级和事务级,会话级临时表当会话结束时，数据清空，事务级临时表，当事务提交时，数据清空
--会话级临时表
CREATE GLOBAL TEMPORARY TABLE temp1(t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32)) ON COMMIT PRESERVE ROWS;
INSERT INTO temp1 VALUES(1,'aaa');
COMMIT;
SELECT * FROM temp1;
--事务级临时表,数据只有在提交之前保留，一旦提交，数据就被清空
CREATE GLOBAL TEMPORARY TABLE temp3(t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32)) ON COMMIT DELETE ROWS;
INSERT INTO temp3 VALUES(2,'aaa');
COMMIT;
SELECT * FROM temp3;
INSERT INTO temp3 VALUES(2,'aaa');
COMMIT;
--删除临时表
DROP TABLE table_name;
