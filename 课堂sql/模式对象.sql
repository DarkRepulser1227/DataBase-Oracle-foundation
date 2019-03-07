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




