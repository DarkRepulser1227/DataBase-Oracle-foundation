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


--使用case语句实现以上功能
DECLARE
v_math student.s_math%TYPE;
BEGIN
  SELECT s_math INTO v_math FROM student WHERE s_name='&请输入姓名';
  DBMS_OUTPUT.put_line(v_math);
  CASE
    WHEN v_math>=120 THEN
      DBMS_OUTPUT.put_line('A');
      WHEN v_math >= 100 THEN
        DBMS_OUTPUT.put_line('B');
        WHEN v_math>=80 THEN 
          DBMS_OUTPUT.put_line('C');
          ELSE 
            DBMS_OUTPUT.put_line('D');
  END CASE;
  END;
  
--查询student表,班长取101开会,团支书去102开会,XX委员去103开会,其他同学不开会
--输入学生姓名,查询该学生的开会地点
SELECT * from student;
DECLARE
v_duty student.S_DUTY%TYPE;
BEGIN
  SELECT s_duty INTO v_duty FROM student WHERE s_name='&name';
  DBMS_OUTPUT.put_line(v_duty);
  --判断职务中是否包含委员
  IF INSTR(v_duty,'委员')>0 THEN
    v_duty:='委员';
    DBMS_OUTPUT.put_line(v_duty);
    END IF;
    CASE v_duty
      WHEN '班长' THEN
        DBMS_OUTPUT.PUT_LINE('101');
        WHEN '团支书'THEN
          DBMS_OUTPUT.PUT_LINE('102');
          WHEN '委员' THEN
            DBMS_OUTPUT.PUT_LINE('103');
            ELSE DBMS_OUTPUT.PUT_LINE('不开会');
        END CASE;
        
  END;

--循环
--简单循环LOOP
--loop
--循环体
--[exit]--执行exit.结束循环,相当于break
--end loop;
--输入1-100的累加之和
DECLARE
v_i NUMBER := 1;
v_sum NUMBER := 0;
BEGIN
  LOOP
    v_sum := v_sum + v_i;
    v_i:= v_i+1;
    IF v_i>100 THEN
      EXIT;
      END IF;
    END LOOP;
    DBMS_OUTPUT.put_line(v_sum);
  END;
  
--使用Loop循环插入数据
CREATE TABLE test_loop (t_id NUMBER PRIMARY KEY,t_name VARCHAR2(32) NOT NULL);
DECLARE
v_i NUMBER := 1;
v_char NUMBER :=97;
BEGIN
  LOOP
    INSERT INTO test_loop VALUES(v_i,CHR(v_char));
    v_i := v_i+1;
    v_char := v_char +1;
    IF v_i>5 THEN
      EXIT;
      END IF;
    END LOOP;
    COMMIT;
  END;
  SELECT * FROM TEST_LOOP;

--WHILE循环
--使用while循环输出1-100之间的所有能被3整除的数,并且统计个数
DECLARE
v_i NUMBER:=1;
v_count NUMBER:=0;
BEGIN
  WHILE v_i<=100 LOOP
    IF MOD(v_i,3)=0 THEN
      DBMS_OUTPUT.put_line(v_i);
      v_count := v_count +1;
      END IF;
      v_i := v_i+1;
    END LOOP;
    DBMS_OUTPUT.put_line('能被3整出的数有'||v_count||'个');
  END;


--FOR循环
--for     in 
--用for循环实现1-100的累加之和
DECLARE
v_sum NUMBER :=0;
v_i NUMBER := 1;
BEGIN
  FOR v_i IN 1..100 LOOP
    v_sum := v_sum + v_i;
    END LOOP;
    DBMS_OUTPUT.put_line(v_sum);
  END;

--使用for循环输出1-50之间的所有能被3整除的数,并且统计个数
DECLARE
v_i NUMBER :=1;
v_count NUMBER :=0;
BEGIN
  FOR v_i IN 1..50 LOOP
    IF MOD(v_i,3)=0 THEN
      DBMS_OUTPUT.put_line(v_i);
      v_count := v_count +1;
      END IF;
    END LOOP;  
    DBMS_OUTPUT.put_line(v_count);
  END;

--使用for循环逆序输出1-10之间的数据
DECLARE
v_i NUMBER := 1;
BEGIN
  FOR v_i IN REVERSE 1..10 LOOP
    DBMS_OUTPUT.put_line(v_i);
    END LOOP;
  END;

--使用for循环实现5的阶乘
--使用循环实现5-1的各自的阶乘,并且先输出5的阶乘,最后输出1的阶乘,循环的嵌套



--变量的作用域
DECLARE
v_total NUMBER := 0;--全局变量
BEGIN
  FOR v_num IN 1..10 LOOP--v_num局部变量
    v_total := v_total+v_num;
    DBMS_OUTPUT.put_line(v_num);    
    END LOOP;
    DBMS_OUTPUT.put_line(v_num); --循环外不能使用v_num
    DBMS_OUTPUT.put_line(v_total);    
  END;
  
--游标:循环符合条件多条记录CUSROR
--使用步骤 1.定义游标.2.打开游标.3.遍历游标 4.关闭游标
--1.定义游标
--cursor cursor_name is select 
--2.打开游标
--open cusror_name
--3.遍历游标
--fetch into 
--4.关闭游标
--close cursor_name
--游标的属性(%)
--1)isopen:结果为布尔值.true已打开,false:未打开
--cursor_abc%isopen
--2)foundsnotfound: 遍历游标时使用,返回结果是最近一次fetch操作的结果,作用为,判断遍历是否结果
--3)%rowcount:到当前为止的记录数
--和loop结合
--查询所有教师的编号和姓名
DECLARE
CURSOR cursor_tea IS SELECT t_id,t_name FROM teacher;--定义游标
v_id teacher.T_ID%TYPE;
V_name teacher.t_name%TYPE;
BEGIN
  IF NOT  cursor_tea%ISOPEN THEN
    OPEN cursor_tea;--打开游标
    END IF;      
    LOOP
      FETCH cursor_tea INTO v_id,v_name;
      EXIT WHEN cursor_tea%NOTFOUND;
      DBMS_OUTPUT.put_line(v_id||','||v_name);
 
     
      END LOOP;   
CLOSE cursor_tea;-- 关闭游标
  END;

--使用while循环和游标结合
--使用while输出男性教师的的姓名和职务
SELECT * FROM teacher;
DECLARE
CURSOR cursor_tea1 IS SELECT t_name,t_duty FROM teacher;
v_name teacher.t_name%TYPE;
v_duty teacher.t_duty%TYPE;
BEGIN
  IF NOT cursor_tea1%ISOPEN THEN
    OPEN cursor_tea1;
    END IF;
     FETCH cursor_tea1 INTO v_name,v_duty;
    WHILE cursor_tea1%FOUND LOOP
       DBMS_OUTPUT.put_line(v_name||','||v_duty);
      FETCH cursor_tea1 INTO v_name,v_duty;
     
      END LOOP;
      CLOSE cursor_tea1;
  END;

--游标和for循环的结合, 不需要些打开和关闭游标的代码
DECLARE 
CURSOR cursor_tea2 IS SELECT t_name,t_duty FROM teacher;
BEGIN
  FOR v_tea IN cursor_tea2 LOOP
    DBMS_OUTPUT.put_line(v_tea.t_name||','||v_tea.t_duty);
  END LOOP;
  END;
  
--数据类型中的%rowtype
--查询教师的id和姓名
DECLARE
v_tea teacher%ROWTYPE;
CURSOR cursor_tea3 IS SELECT * FROM teacher;
BEGIN
  IF NOT cursor_tea3%ISOPEN THEN
    OPEN cursor_tea3;
    END IF;
    LOOP
      FETCH cursor_tea3 INTO v_tea;
      EXIT WHEN cursor_tea3%NOTFOUND;
      dbms_output.put_line(v_tea.t_id||','||v_tea.t_name);
      END LOOP;
      CLOSE cursor_tea3;
  END;


--游标用于增删改 for update
--将职务为生活委员的学生的职务,改为副班长
DECLARE
CURSOR cursor_stu1 IS SELECT s_name,s_duty FROM student WHERE s_duty='生活委员' FOR UPDATE OF s_duty;
BEGIN
  FOR v_stu IN cursor_stu1 LOOP
    UPDATE student SET s_duty='副班长' WHERE CURRENT OF cursor_stu1;
    END LOOP;
    COMMIT;
  END;

SELECT * FROM student WHERE s_duty='副班长';

--查询学历表中,名称为中专的记录,如果有,就删除,没有,显示无该条记录
DECLARE
CURSOR cursor_diploma IS SELECT * FROM diploma WHERE diploma_name='中专' FOR UPDATE;
v_count NUMBER := 0;
BEGIN
  FOR v_diploma IN cursor_diploma LOOP
  DELETE FROM diploma WHERE CURRENT OF cursor_diploma;
  DBMS_OUTPUT.put_line('找到该记录,并已经删除');
   v_count := cursor_diploma%ROWCOUNT;
   
  END LOOP;
 
  IF v_count= 0 THEN
    DBMS_OUTPUT.put_line('该记录不存在');
    END IF;
  COMMIT;
  END;

INSERT INTO diploma VALUES(1,'中专');
COMMIT;

SELECT * FROM diploma;

--隐式游标(sql):一般用于增删改的时候,DML和DQL都会打开一个隐式游标,当commit的时候就关闭了
--使用隐式游标改进以上例子


BEGIN
  DELETE FROM diploma WHERE DIPLOMA_NAME='中专';
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.put_line('未找到该记录');
    ELSE 
       DBMS_OUTPUT.put_line('以删除');
    END IF;
  END;


--异常:分类
--1)预定义异常
--DUP_VAL_ON_INDEX:重复值异常
--NO_DATE_FOUND:数据不能找到
--ZERO_DIVIDE:除零异常
--2)非预定义异常

--3)用户自定义异常

--SQLCODE:异常编号
--SQLERRM:异常描述
--异常编号的范围对应的异常类型
--负数:错误
--0:没有异常
--+1:用户自定义一样
--+100:,没有符合条件的记录

--尝试将教师表中的省份证号,改成相同的,会报什么异常

SELECT * FROM teacher;



BEGIN
  UPDATE teacher SET T_IDCARD='130225197110048213' WHERE t_name='李飞';
  EXCEPTION
    WHEN dup_val_on_index  THEN 
      DBMS_OUTPUT.put_line(SQLCODE);
       DBMS_OUTPUT.put_line(SQLERRM);
        DBMS_OUTPUT.put_line('身份证号不能重复');
  END;


--除零异常
DECLARE
v_num NUMBER;
BEGIN
  v_num:=2/0;
  EXCEPTION 
    WHEN OTHERS THEN 
      DBMS_OUTPUT.put_line(SQLCODE);
END;







  
  
