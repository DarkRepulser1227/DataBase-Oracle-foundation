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





