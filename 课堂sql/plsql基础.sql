--pl/sql
--程序快
--[DECLARE]
--begin
--[exception]
--end
--变量的命名规则
--1）必须字母开头
--2）由一个或多个的字母和数字以及符号（$,#,_）
--3) 长度不能超过30个字符
--4）不能含有空格
SELECT * FROM stu;
--查询id为1的学生的性别和性别
DECLARE
v_name VARCHAR2(32);
v_gender VARCHAR2(60);
BEGIN
  SELECT s_name,s_gender INTO v_name,v_gender FROM stu WHERE s_id=1;
  DBMS_OUTPUT.put_line(v_name);
  DBMS_OUTPUT.put_line(v_gender);
  END;
--查询编号为060001的教师，和他相同学历的教师人数
SELECT * FROM teacher;
SELECT * FROM DIPLOMA;
DECLARE
v_diplomaid NUMBER;
v_count NUMBER;
v_diploma_name VARCHAR2(32);
BEGIN
  SELECT T_DIPLOMAID INTO v_diplomaid FROM teacher WHERE t_id='060001';
  DBMS_OUTput.put_line(v_diplomaid);
  SELECT DIPLOMA_name INTO v_diploma_name FROM DIPLOMA WHERE DIPLOMA_ID=v_diplomaid;
  SELECT COUNT(*) INTO v_count FROM teacher WHERE T_DIPLOMAID=v_diplomaid;
  DBMS_OUTPUt.put_line(v_diploma_name||'人数为：'||v_count);
 
  END;

--向学历表中插入一条记录
DECLARE
BEGIN
  INSERT INTO DIPLOMA VALUES(6,'其他');
  COMMIT;
  END;
  
--删除学历表中名称为其他的记录
BEGIN
  DELETE FROM diploma WHERE DIPLOMA_NAME='其他';
  COMMIT;
  END;
  
--查询指定教师编号的教师的姓名
DECLARE
v_name VARCHAR(32);
BEGIN
  SELECT t_name INTO v_name FROM teacher WHERE t_id='&请输入教师编号';
  DBMS_OUTput.put_line(v_name);
  END;
--plsql支持的数据类型
--字符型，数值型，日期型，布尔型，参考类型（%type,%rowtype）

-- 把上面的例子改为%type
DECLARE
v_name teacher.t_name%TYPE;
BEGIN
    SELECT t_name INTO v_name FROM teacher WHERE t_id='&请输入教师编号';
  DBMS_OUTput.put_line(v_name);
  END;
  
--赋值语句 ：=
DECLARE
v_a NUMBER :=2;
v_b NUMBER :=3;
v_result NUMBER;
BEGIN
  v_result := v_a+v_b;
  DBMS_OUTPUT.put_LINE(v_result);
  END;

DECLARE
v_a NUMBER;
v_b NUMBER;
v_result NUMBER;
BEGIN
  v_a :=2;
  v_b:=3;
  v_result := v_a+v_b;
  DBMS_OUTPUT.put_LINE(v_result);
  END;

--选择结构 if-then-else
--查询工商083班的语文成绩的平均分，是否在90分以上
DECLARE
v_avg student.S_CHINESE%TYPE;
BEGIN
  SELECT AVG(s_chinese) INTO v_avg FROM student WHERE s_classname='工商083';
  DBMS_OUTPUT.put_line(v_avg);
  IF v_avg>90 THEN 
    DBMS_OUTPUT.put_line('yes');
    ELSE 
      DBMS_OUTPUT.put_line('no');
      END IF;
  END;

--多个ifelse
--姓名为李丹丹的学生的数学成绩的优良中差
SELECT * FROM student;
DECLARE
v_math student.S_MATH%TYPE;
BEGIN
  SELECT s_math INTO v_math FROM student WHERE s_name='&请输入要学生姓名';
  DBMS_OUTPUT.put_line(v_math);
  IF v_math>=120 THEN 
    DBMS_OUTPUT.put_line('A');
    ELSIF v_math >=100 THEN
      DBMS_OUTPUT.put_line('B');
      ELSIF v_math>=80 THEN
        DBMS_OUTPUT.put_line('C');
        ELSE 
          DBMS_OUTPUT.put_line('D');
    END IF;
  END;





