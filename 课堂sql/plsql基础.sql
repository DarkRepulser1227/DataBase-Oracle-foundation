--pl/sql
--�����
--[DECLARE]
--begin
--[exception]
--end
--��������������
--1��������ĸ��ͷ
--2����һ����������ĸ�������Լ����ţ�$,#,_��
--3) ���Ȳ��ܳ���30���ַ�
--4�����ܺ��пո�
SELECT * FROM stu;
--��ѯidΪ1��ѧ�����Ա���Ա�
DECLARE
v_name VARCHAR2(32);
v_gender VARCHAR2(60);
BEGIN
  SELECT s_name,s_gender INTO v_name,v_gender FROM stu WHERE s_id=1;
  DBMS_OUTPUT.put_line(v_name);
  DBMS_OUTPUT.put_line(v_gender);
  END;
--��ѯ���Ϊ060001�Ľ�ʦ��������ͬѧ���Ľ�ʦ����
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
  DBMS_OUTPUt.put_line(v_diploma_name||'����Ϊ��'||v_count);
 
  END;

--��ѧ�����в���һ����¼
DECLARE
BEGIN
  INSERT INTO DIPLOMA VALUES(6,'����');
  COMMIT;
  END;
  
--ɾ��ѧ����������Ϊ�����ļ�¼
BEGIN
  DELETE FROM diploma WHERE DIPLOMA_NAME='����';
  COMMIT;
  END;
  
--��ѯָ����ʦ��ŵĽ�ʦ������
DECLARE
v_name VARCHAR(32);
BEGIN
  SELECT t_name INTO v_name FROM teacher WHERE t_id='&�������ʦ���';
  DBMS_OUTput.put_line(v_name);
  END;
--plsql֧�ֵ���������
--�ַ��ͣ���ֵ�ͣ������ͣ������ͣ��ο����ͣ�%type,%rowtype��

-- ����������Ӹ�Ϊ%type
DECLARE
v_name teacher.t_name%TYPE;
BEGIN
    SELECT t_name INTO v_name FROM teacher WHERE t_id='&�������ʦ���';
  DBMS_OUTput.put_line(v_name);
  END;
  
--��ֵ��� ��=
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

--ѡ��ṹ if-then-else
--��ѯ����083������ĳɼ���ƽ���֣��Ƿ���90������
DECLARE
v_avg student.S_CHINESE%TYPE;
BEGIN
  SELECT AVG(s_chinese) INTO v_avg FROM student WHERE s_classname='����083';
  DBMS_OUTPUT.put_line(v_avg);
  IF v_avg>90 THEN 
    DBMS_OUTPUT.put_line('yes');
    ELSE 
      DBMS_OUTPUT.put_line('no');
      END IF;
  END;

--���ifelse
--����Ϊ�����ѧ������ѧ�ɼ��������в�
SELECT * FROM student;
DECLARE
v_math student.S_MATH%TYPE;
BEGIN
  SELECT s_math INTO v_math FROM student WHERE s_name='&������Ҫѧ������';
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


--ʹ��case���ʵ�����Ϲ���
DECLARE
v_math student.s_math%TYPE;
BEGIN
  SELECT s_math INTO v_math FROM student WHERE s_name='&����������';
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
  
--��ѯstudent��,�೤ȡ101����,��֧��ȥ102����,XXίԱȥ103����,����ͬѧ������
--����ѧ������,��ѯ��ѧ���Ŀ���ص�
SELECT * from student;
DECLARE
v_duty student.S_DUTY%TYPE;
BEGIN
  SELECT s_duty INTO v_duty FROM student WHERE s_name='&name';
  DBMS_OUTPUT.put_line(v_duty);
  --�ж�ְ�����Ƿ����ίԱ
  IF INSTR(v_duty,'ίԱ')>0 THEN
    v_duty:='ίԱ';
    DBMS_OUTPUT.put_line(v_duty);
    END IF;
    CASE v_duty
      WHEN '�೤' THEN
        DBMS_OUTPUT.PUT_LINE('101');
        WHEN '��֧��'THEN
          DBMS_OUTPUT.PUT_LINE('102');
          WHEN 'ίԱ' THEN
            DBMS_OUTPUT.PUT_LINE('103');
            ELSE DBMS_OUTPUT.PUT_LINE('������');
        END CASE;
        
  END;

--ѭ��
--��ѭ��LOOP
--loop
--ѭ����
--[exit]--ִ��exit.����ѭ��,�൱��break
--end loop;
--����1-100���ۼ�֮��
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
  
--ʹ��Loopѭ����������
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

--WHILEѭ��
--ʹ��whileѭ�����1-100֮��������ܱ�3��������,����ͳ�Ƹ���
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
    DBMS_OUTPUT.put_line('�ܱ�3����������'||v_count||'��');
  END;


--FORѭ��
--for     in 
--��forѭ��ʵ��1-100���ۼ�֮��
DECLARE
v_sum NUMBER :=0;
v_i NUMBER := 1;
BEGIN
  FOR v_i IN 1..100 LOOP
    v_sum := v_sum + v_i;
    END LOOP;
    DBMS_OUTPUT.put_line(v_sum);
  END;

--ʹ��forѭ�����1-50֮��������ܱ�3��������,����ͳ�Ƹ���
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

--ʹ��forѭ���������1-10֮�������
DECLARE
v_i NUMBER := 1;
BEGIN
  FOR v_i IN REVERSE 1..10 LOOP
    DBMS_OUTPUT.put_line(v_i);
    END LOOP;
  END;

--ʹ��forѭ��ʵ��5�Ľ׳�
--ʹ��ѭ��ʵ��5-1�ĸ��ԵĽ׳�,���������5�Ľ׳�,������1�Ľ׳�,ѭ����Ƕ��



--������������
DECLARE
v_total NUMBER := 0;--ȫ�ֱ���
BEGIN
  FOR v_num IN 1..10 LOOP--v_num�ֲ�����
    v_total := v_total+v_num;
    DBMS_OUTPUT.put_line(v_num);    
    END LOOP;
    DBMS_OUTPUT.put_line(v_num); --ѭ���ⲻ��ʹ��v_num
    DBMS_OUTPUT.put_line(v_total);    
  END;
  
--�α�:ѭ����������������¼CUSROR
--ʹ�ò��� 1.�����α�.2.���α�.3.�����α� 4.�ر��α�
--1.�����α�
--cursor cursor_name is select 
--2.���α�
--open cusror_name
--3.�����α�
--fetch into 
--4.�ر��α�
--close cursor_name
--�α������(%)
--1)isopen:���Ϊ����ֵ.true�Ѵ�,false:δ��
--cursor_abc%isopen
--2)foundsnotfound: �����α�ʱʹ��,���ؽ�������һ��fetch�����Ľ��,����Ϊ,�жϱ����Ƿ���
--3)%rowcount:����ǰΪֹ�ļ�¼��
--��loop���
--��ѯ���н�ʦ�ı�ź�����
DECLARE
CURSOR cursor_tea IS SELECT t_id,t_name FROM teacher;--�����α�
v_id teacher.T_ID%TYPE;
V_name teacher.t_name%TYPE;
BEGIN
  IF NOT  cursor_tea%ISOPEN THEN
    OPEN cursor_tea;--���α�
    END IF;      
    LOOP
      FETCH cursor_tea INTO v_id,v_name;
      EXIT WHEN cursor_tea%NOTFOUND;
      DBMS_OUTPUT.put_line(v_id||','||v_name);
 
     
      END LOOP;   
CLOSE cursor_tea;-- �ر��α�
  END;

--ʹ��whileѭ�����α���
--ʹ��while������Խ�ʦ�ĵ�������ְ��
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

--�α��forѭ���Ľ��, ����ҪЩ�򿪺͹ر��α�Ĵ���
DECLARE 
CURSOR cursor_tea2 IS SELECT t_name,t_duty FROM teacher;
BEGIN
  FOR v_tea IN cursor_tea2 LOOP
    DBMS_OUTPUT.put_line(v_tea.t_name||','||v_tea.t_duty);
  END LOOP;
  END;
  
--���������е�%rowtype
--��ѯ��ʦ��id������
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


--�α�������ɾ�� for update
--��ְ��Ϊ����ίԱ��ѧ����ְ��,��Ϊ���೤
DECLARE
CURSOR cursor_stu1 IS SELECT s_name,s_duty FROM student WHERE s_duty='����ίԱ' FOR UPDATE OF s_duty;
BEGIN
  FOR v_stu IN cursor_stu1 LOOP
    UPDATE student SET s_duty='���೤' WHERE CURRENT OF cursor_stu1;
    END LOOP;
    COMMIT;
  END;

SELECT * FROM student WHERE s_duty='���೤';

--��ѯѧ������,����Ϊ��ר�ļ�¼,�����,��ɾ��,û��,��ʾ�޸�����¼
DECLARE
CURSOR cursor_diploma IS SELECT * FROM diploma WHERE diploma_name='��ר' FOR UPDATE;
v_count NUMBER := 0;
BEGIN
  FOR v_diploma IN cursor_diploma LOOP
  DELETE FROM diploma WHERE CURRENT OF cursor_diploma;
  DBMS_OUTPUT.put_line('�ҵ��ü�¼,���Ѿ�ɾ��');
   v_count := cursor_diploma%ROWCOUNT;
   
  END LOOP;
 
  IF v_count= 0 THEN
    DBMS_OUTPUT.put_line('�ü�¼������');
    END IF;
  COMMIT;
  END;

INSERT INTO diploma VALUES(1,'��ר');
COMMIT;

SELECT * FROM diploma;

--��ʽ�α�(sql):һ��������ɾ�ĵ�ʱ��,DML��DQL�����һ����ʽ�α�,��commit��ʱ��͹ر���
--ʹ����ʽ�α�Ľ���������


BEGIN
  DELETE FROM diploma WHERE DIPLOMA_NAME='��ר';
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.put_line('δ�ҵ��ü�¼');
    ELSE 
       DBMS_OUTPUT.put_line('��ɾ��');
    END IF;
  END;


--�쳣:����
--1)Ԥ�����쳣
--DUP_VAL_ON_INDEX:�ظ�ֵ�쳣
--NO_DATE_FOUND:���ݲ����ҵ�
--ZERO_DIVIDE:�����쳣
--2)��Ԥ�����쳣

--3)�û��Զ����쳣

--SQLCODE:�쳣���
--SQLERRM:�쳣����
--�쳣��ŵķ�Χ��Ӧ���쳣����
--����:����
--0:û���쳣
--+1:�û��Զ���һ��
--+100:,û�з��������ļ�¼

--���Խ���ʦ���е�ʡ��֤��,�ĳ���ͬ��,�ᱨʲô�쳣

SELECT * FROM teacher;



BEGIN
  UPDATE teacher SET T_IDCARD='130225197110048213' WHERE t_name='���';
  EXCEPTION
    WHEN dup_val_on_index  THEN 
      DBMS_OUTPUT.put_line(SQLCODE);
       DBMS_OUTPUT.put_line(SQLERRM);
        DBMS_OUTPUT.put_line('���֤�Ų����ظ�');
  END;


--�����쳣
DECLARE
v_num NUMBER;
BEGIN
  v_num:=2/0;
  EXCEPTION 
    WHEN OTHERS THEN 
      DBMS_OUTPUT.put_line(SQLCODE);
END;







  
  
