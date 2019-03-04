--多表查询
--内连接
SELECT * FROM stu;
SELECT * FROM banji;
SELECT * FROM tea;

SELECT t_id,t_name_new FROM tea,banji;--不是内连接
--内连接的两种语法
--1.用where子句指明连接条件
SELECT t_id,t_name_new FROM tea,banji WHERE banji.B_TEACHER_ID=tea.T_ID AND b_name='计算机四班';
--2，用join on
SELECT t_id,t_name_new FROM tea JOIN banji ON banji.b_teacher_id=tea.t_id WHERE b_name='计算机四班';
--3.join using(两个表中的主外键关联列，必须具有相同的数据类型和字段名称)
ALTER TABLE banji RENAME COLUMN b_teacher_id TO t_id;
SELECT t_id,t_name_new FROM tea JOIN banji USING (t_id) WHERE b_name='计算机四班';
ALTER TABLE banji RENAME COLUMN t_id TO b_teacher_id;

--查询计算机一班的学生有哪些
SELECT s_name,s_id FROM banji INNER JOIN stu ON B_ID=s_BANJI_ID
WHERE b_name='计算机一班';

--查询教师abc的班级的上课地点
SELECT b_location,t_name_new FROM banji JOIN tea ON b_teacher_id=t_id WHERE t_name_new='abc'; 

--查询abc老师所在的班级的语文平均分
SELECT AVG(s_chn) FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
WHERE t_name_new='abc';

--查询语文平均分>60分的班级的老师和上课地点
SELECT b_id FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
GROUP BY b_id HAVING AVG(s_chn)>60;

SELECT t_name_new,b_location FROM banji JOIN tea ON b_teacher_id=t_id
WHERE b_id IN(SELECT b_id FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
GROUP BY b_id HAVING AVG(s_chn)>60);

--外连接：左外（left outer），右外（right outer），全外（full outer），outer可以省略
--左外连接：以左边表为基准
SELECT b_id,b_name,b_location,t_name_new FROM banji LEFT OUTER JOIN tea ON B_TEACHER_ID=t_id;
SELECT b_id,b_name,b_location,t_name_new FROM tea LEFT OUTER JOIN banji ON B_TEACHER_ID=t_id;
--右外连接：以右边表为基准
SELECT b_id,b_name,b_location,t_name_new FROM banji RIGHT  OUTER JOIN tea ON B_TEACHER_ID=t_id;
SELECT b_id,b_name,b_location,t_name_new FROM tea RIGHT OUTER JOIN banji ON B_TEACHER_ID=t_id;
--全外连接
SELECT b_id,b_name,b_location,t_name_new FROM tea FULL  OUTER JOIN banji ON B_TEACHER_ID=t_id;
--外连接还可以用加号表示，加号放在没有记录，就被设为空值的一端
SELECT b_id,b_name,b_location,t_name_new FROM banji JOIN tea ON B_TEACHER_ID(+)=t_id;
--自然连接：NATURAL （主外键关联字段有相同数据类型和相同的字段名称,连接的字段名称可以省略,效果等同于内连接）
ALTER TABLE banji RENAME COLUMN b_teacher_id TO t_id;
SELECT t_name_new,b_id FROM tea NATURAL JOIN banji;
--笛卡儿积连接 CROSS
SELECT t_name_new,b_id FROM tea CROSS JOIN banji;


--并，差，交
--并：union，union all
--查询男生语文成绩>60和女生数学成绩>80的记录
SELECT s_name,s_gender FROM stu
WHERE s_gender='male' AND s_chn>=60
UNION
SELECT s_name,s_gender,s_math FROM stu
WHERE s_gender='female' AND s_math>=80;

--union和union all的区别
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
UNION--去掉重复值
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
UNION ALL--简单把多个结果集并在一起
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

--交:INTERSECT
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
INTERSECT --取两个结果集中共同出现的记录
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

--差：
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
MINUS  --从前面的结果集中减去两个结果中相同的记录
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;
