--常用函数
--一、字符类函数
--1.ASCII码：将字符转换为ASCII码
SELECT ASCII ('中'), ASCII('A'), ASCII('a') FROM dual;
--2.CHR：将ASCII码转成相应字符
SELECT CHR(14989485),CHR(65),CHR(97)  FROM dual;
--3.concat:：字符串连接，与||功能一样
SELECT s_name,s_gender, '总分为：'||(s_math+s_chn+s_eng) FROM  student;
SELECT s_name,s_gender,CONCAT('总分为：',s_math+s_chn+s_eng) FROM student;
--查询谁是什么性别
SELECT concat(CONCAT(s_name,' is '),s_gender) FROM student;
--4.Initcap：返回第一个字母为大写的形式
SELECT  initcap('this is a tree') FROM dual;
--5.Instr
SELECT s_name,INSTR(s_name,'张') FROM student;
--查询包含字母‘’张的学生姓名
SELECT s_name FROM student WHERE INSTR (s_name,'张')>0;
--6.Lower,upper
SELECT LOWER('This is a tree') FROM dual;
SELECT UPPER('This is a tree') FROM dual;
--7.length，lenthb求长度
SELECT LENGTH('我爱学习数据库'),Lengthb('我爱学习数据库') FROM dual;
--8.LPAD,RPAD：在字符串的左边或右边补齐自定义字符
--三个参（字符串或属性名，补齐的字符串长度，补齐的自定义字符）
SELECT s_id,LPAD(s_id,10,0) FROM student;
--9.replace替换
--三个参（字符串或属性名，改动串，目标串）
SELECT  s_name,Replace(s_name,'张','李') FROM student;
--10.Substr：求一个字符串中的子串
--三个参（字符串或属性名，起始位置，截取的字符个数）
SELECT s_name,Substr(s_name,1,2)    FROM student;
SELECT s_name,Substr(s_name,-2,2)  FROM student;
--重命名student表
RENAME student TO stu;
--二、数值型函数
--1.ABS绝对值
SELECT ABS(1),ABS(-450) FROM dual;
--2.CEIL：对小数进行上取整
SELECT CEIL(10.5),CEIL(-10.5)  FROM  dual;
--3.floor 下取整
SELECT FLOOR (10.5),FLOOR(-10.5) FROM dual;
--4.round 四舍五入
SELECT ROUND(10.5),ROUND(10.759,1) FROM dual;
--5.MOD：取余
SELECT MOD(10,4) FROM dual;
--6.Turnc：取整，不四舍五入
SELECT TRUNC （10.5），TRUNC(1.789,1) FROM dual;
--三、日期型函数
--1.ADD_Months
SELECT t_entertime,add_months(t_entertime,12),add_months(t_entertime,-12) FROM teacher;
--2.获取当前系统时间
SELECT SYSDATE FROM dual;
SELECT CURREENT_date FROM dual;
SELECT current_timestamp FROM dual;
--3.extract获取时间信息的指定部分
--查询2007年入职的老师，入职月份
SELECT t_name,t_entertime,EXTRACT(MONTH FROM t_entertime) FROM teacher to_char(t_entertime,'yyyy-mm-dd') LIKE '2007%'
--4.last_day：获取某月最后一天
SELECT last_day(Sysdate) FROM dual;
--5.next_day：获取当前日期之后的下一个周几
SELECT next_day(SYSDATE,1) FROM dual;--注意周几的表示习惯
