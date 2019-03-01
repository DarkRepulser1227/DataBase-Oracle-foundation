--select 语句的执行顺序
--from->where->group by->having->select->distinct->order by  

--伪表dual的使用
SELECT 3+2 FROM  dual;
SELECT  *  FROM  student;
--将student表的s_score重命名为s_math
ALTER  TABLE  student  RENAME  COLUMN  s_score  TO  s_math;
--为student表添加两个字段，s_chn,s_eng
ALTER  TABLE  student  ADD  s_chn  NUMBER(4,1);
ALTER  TABLE  student  ADD  s_eng  NUMBER(4,1);
--为student表添加数据
UPDATE  student  SET s_chn=92,s_eng=95 WHERE s_id=1;
UPDATE  student  SET s_chn=72,s_eng=80 WHERE s_id=2;
UPDATE  student  SET s_chn=100,s_eng=100 WHERE s_id=3;
UPDATE  student  SET s_chn=87,s_eng=85 WHERE s_id=4;
UPDATE  student  SET s_chn=70,s_eng=60 WHERE s_id=5;
UPDATE  student  SET s_chn=50,s_eng=57 WHERE s_id=6;
--select子句的数学运算
SELECT  s_math+s_chn+s_eng FROM student;
SELECT s_name,s_gender,s_math+s_chn+s_eng FROM student;
--为属性设置别名(as可以省略)
SELECT s_name,s_gender,s_math+s_chn+s_eng AS total FROM student;
SELECT s_name,s_gender,s_math+s_chn+s_eng       total FROM student;
--聚合函数 count  sum  avg  max  min
SELECT COUNT(*)  FROM  student;
SELECT SUM(s_math),AVG (s_math) FROM student;
SELECT  MAX(s_math),MIN(s_math) FROM student;
--字符串连接运算符
SELECT '人数为：' || COUNT(*)  FROM  student;
SELECT '姓名为：' || s_name FROM  student;
--where子句
SELECT *  FROM  student WHERE  s_math<60;
SELECT *  FROM  student WHERE  s_math>=60;
SELECT *  FROM  student WHERE  s_math=99;
SELECT *  FROM  student WHERE  s_math!=99;--<>

--where子句中的逻辑运算（and, or, not）
SELECT  *  FROM  student  WHERE  s_math>=70  AND  s_math<80;
SELECT  *  FROM  student  WHERE  s_math<70  OR  s_math>=80;
--使用between...and...(闭区间)
SELECT  *  FROM  student  WHERE  s_math  BETWEEN 90  AND  100;
--in  和  not  in
SELECT  *  FROM  student WHERE  s_id  IN(1,2,5);
SELECT  *  FROM  student WHERE  s_id  NOT  IN(1,2,5);
--模糊查询
--两个通配符1.%(任意多个的任意字符) 2. _(一个任意字符)
--查询所有含有字母a的学生
--like  和  not  like
SELECT  *  FROM student  WHERE s_name  LIKE  '%张%';
SELECT  *  FROM student  WHERE s_name  NOT  LIKE  '%张%';
--查询姓名为字母a开投，并且由3个字符构成的姓名
SELECT  *  FROM  student  WHERE  s_name LIKE  'a__';
SELECT  *  FROM  student  WHERE  s_name NOT LIKE  'a__';
--查询1992年9月出生的学生
SELECT  *  FROM  student  WHERE  to_char(s_birthday,'yyyy-mm-dd') LIKE  '1992-09%';
--is null  和  is  not  null
--查询教师表中电话为空值的人
INSERT  INTO  tea(t_id,t_name_new,t_gender,t_birthday)
VALUES  (8,'ggg','male',to_date('1996-01-01','yyyy-mm-dd'));
SELECT *  FROM  tea  WHERE  t_phone IS NULL;
SELECT *  FROM  tea  WHERE  t_phone IS NOT NULL;
--distinct 关键字 （去掉重复）
SELECT  s_banji_id FROM  student;
SELECT DISTINCT  s_banji_id FROM student;
--伪列
--rownum:把符合条件的记录从一开始编号
--rowid：行的id号，类似于哈希码
SELECT  s_name,s_gender,s_math  FROM  student WHERE  s_gender='male';
SELECT  rownum,rowid,s_name,s_gender,s_math  FROM  student WHERE  s_gender='male';
--类似于top和liimit的功能
SELECT  s_id,s_name,s_math FROM  studen  ORDER  BY  s_math DESC;
--子查询
SELECT ROWNUM,s_id,s_name,s_math 
FROM (SELECT  s_id,s_name,s_math FROM  student  ORDER  BY  s_math DESC)
WHERE  rownum<=3  ORDER BY  ROWNUM;
--group by ;分组
--按照班级查询各个班级的数学平均分
SELECT s_banji_id,AVG(s_math)  FROM  student GROUP BY  s_banji_id;
--SELECT s_banji_id,AVG(s_math)  FROM  student GROUP BY  s_gender;
SELECT s_gender,AVG(s_math)  FROM  student GROUP BY  s_gender;
--having：必须跟随group by
--查询班级数学平均分及格的班级有哪些；
SELECT s_banji_id,AVG(s_math)
FROM student 
GROUP BY s_banji_id HAVING AVG(s_math)>=60;
--order by ,可以设置多排序关键字
--按照数学成绩升序排序(ASC)
SELECT *  FROM student ORDER BY s_math;
--按照数学成绩升序排序,如果数学成绩相同，则按照语文成绩升序
SELECT *  FROM student ORDER BY s_math,s_chn;
--降序
SELECT *  FROM student ORDER BY s_math DESC ,s_chn DESC;
--查询各个班级的男生三科成绩总分并显总分的平均分大于180分的学生，并按照总分降序
SELECT  s_banji_id,avg(s_math+s_chn+s_eng) FROM student 
WHERE  s_gender='male'
GROUP BY s_banji_id 
HAVING avg(s_math+s_chn+s_eng) >=180
ORDER BY avg(s_math+s_chn+s_eng) DESC;
