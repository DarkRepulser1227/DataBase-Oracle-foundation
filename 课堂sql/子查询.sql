--1.子查询
--可以使用的运算符   in，any（some），all
SELECT * FROM stu;
SELECT * FROM banji;
--查询计算机一班学生有哪些
SELECT b_id FROM banji WHERE b_name='计算机一班';
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT b_id FROM banji WHERE b_name='计算机一班');
--查询和wangwu同班级的所有学生
SELECT s_banji_id FROM stu WHERE s_name='wangwu';
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT s_banji_id FROM stu WHERE s_name='wangwu');

--查询和张三同班并且性别相同的学生有哪些
SELECT s_gender,s_banji_id FROM stu WHERE s_name='zhangsan';
SELECT * FROM stu 
WHERE (s_gender,s_banji_id)=(SELECT s_gender,s_banji_id FROM stu WHERE s_name='zhangsan');


--子查询也可以出现在from之后,见使用rownum查询top前几个
--子查询可可以出现在select里
--通过一条查询语句，查询教师的人数和学生的人数
SELECT COUNT(*) AS 教室数量 FROM tea;
SELECT COUNT(*) AS 学生数量 FROM stu;
SELECT (SELECT COUNT(*) FROM tea) AS 教师数量，(SELECT COUNT(*) FROM stu) AS 学生数量
FROM dual; 
--查询班主任为abc的学生有哪些
SELECT t_id FROM tea WHERE t_name_new='abc';
SELECT b_id FROM banji WHERE B_TEACHER_ID=(SELECT t_id FROM tea WHERE t_name_new='abc');
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT b_id FROM banji WHERE B_TEACHER_ID=(SELECT t_id FROM tea WHERE t_name_new='abc'));
--运算符：in
--查询在301和302上课的学生有哪些
SELECT b_id FROM banji WHERE b_location IN ('301','302');
SELECT s_name,s_banji_id FROM stu
WHERE s_banji_id  IN (SELECT b_id FROM banji WHERE b_location IN ('301','302'));
--any 和some，有一个满足条件就可以,在any之前必须使用当行操作符
--查询数学成绩大于任意一个班级的数学成绩平均分的学生
SELECT s_banji_id,AVG(s_math) FROM stu GROUP BY s_banji_id;
SELECT s_name,s_banji_id,s_math FROM stu
WHERE s_math > ANY(SELECT AVG(s_math) FROM stu GROUP BY s_banji_id);

--all：都要满足
--查询哪些学生的数学成绩，比所有班级的数学平均分还要高的学生
SELECT s_name,s_banji_id,s_math FROM stu
WHERE s_math > ALL (SELECT AVG(s_math) FROM stu GROUP BY s_banji_id);

--子查询出现在insert，update，delete中
--1）insert
--创建新表tea_female, 将女教师的id，姓名放到新表中
CREATE TABLE tea_female (t_id NUMBER,t_name VARCHAR2(20));
SELECT t_id,t_name_new FROM tea WHERE t_gender='female';
INSERT INTO tea_female (SELECT t_id,t_name_new FROM tea WHERE t_gender='female');
SELECT * FROM tea_female;

--2)update
--把和zhangsan同班的学生的数学成绩提高10%

SELECT s_banji_id FROM stu WHERE s_name='zhangsan';
UPDATE stu SET s_math=s_math*1.1
WHERE s_banji_id=(SELECT s_banji_id FROM stu WHERE s_name='zhangsan');
COMMIT;
SELECT * FROM stu;

--3)delete语句中
--将和张三数学成绩一样的学生的记录删除
SELECT s_math FROM stu WHERE s_name='zhangsan';
DELETE FROM stu
WHERE s_math = (SELECT s_math FROM stu WHERE s_name='zhangsan');
COMMIT;

