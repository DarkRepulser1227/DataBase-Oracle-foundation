--���ú���
--һ���ַ��ຯ��
--1.ASCII�룺���ַ�ת��ΪASCII��
SELECT ASCII ('��'), ASCII('A'), ASCII('a') FROM dual;
--2.CHR����ASCII��ת����Ӧ�ַ�
SELECT CHR(14989485),CHR(65),CHR(97)  FROM dual;
--3.concat:���ַ������ӣ���||����һ��
SELECT s_name,s_gender, '�ܷ�Ϊ��'||(s_math+s_chn+s_eng) FROM  student;
SELECT s_name,s_gender,CONCAT('�ܷ�Ϊ��',s_math+s_chn+s_eng) FROM student;
--��ѯ˭��ʲô�Ա�
SELECT concat(CONCAT(s_name,' is '),s_gender) FROM student;
--4.Initcap�����ص�һ����ĸΪ��д����ʽ
SELECT  initcap('this is a tree') FROM dual;
--5.Instr
SELECT s_name,INSTR(s_name,'��') FROM student;
--��ѯ������ĸ�����ŵ�ѧ������
SELECT s_name FROM student WHERE INSTR (s_name,'��')>0;
--6.Lower,upper
SELECT LOWER('This is a tree') FROM dual;
SELECT UPPER('This is a tree') FROM dual;
--7.length��lenthb�󳤶�
SELECT LENGTH('�Ұ�ѧϰ���ݿ�'),Lengthb('�Ұ�ѧϰ���ݿ�') FROM dual;
--8.LPAD,RPAD�����ַ�������߻��ұ߲����Զ����ַ�
--�����Σ��ַ�������������������ַ������ȣ�������Զ����ַ���
SELECT s_id,LPAD(s_id,10,0) FROM student;
--9.replace�滻
--�����Σ��ַ��������������Ķ�����Ŀ�괮��
SELECT  s_name,Replace(s_name,'��','��') FROM student;
--10.Substr����һ���ַ����е��Ӵ�
--�����Σ��ַ���������������ʼλ�ã���ȡ���ַ�������
SELECT s_name,Substr(s_name,1,2)    FROM student;
SELECT s_name,Substr(s_name,-2,2)  FROM student;
--������student��
RENAME student TO stu;
--������ֵ�ͺ���
--1.ABS����ֵ
SELECT ABS(1),ABS(-450) FROM dual;
--2.CEIL����С��������ȡ��
SELECT CEIL(10.5),CEIL(-10.5)  FROM  dual;
--3.floor ��ȡ��
SELECT FLOOR (10.5),FLOOR(-10.5) FROM dual;
--4.round ��������
SELECT ROUND(10.5),ROUND(10.759,1) FROM dual;
--5.MOD��ȡ��
SELECT MOD(10,4) FROM dual;
--6.Turnc��ȡ��������������
SELECT TRUNC ��10.5����TRUNC(1.789,1) FROM dual;
--���������ͺ���
--1.ADD_Months
SELECT t_entertime,add_months(t_entertime,12),add_months(t_entertime,-12) FROM teacher;
--2.��ȡ��ǰϵͳʱ��
SELECT SYSDATE FROM dual;
SELECT CURREENT_date FROM dual;
SELECT current_timestamp FROM dual;
--3.extract��ȡʱ����Ϣ��ָ������
--��ѯ2007����ְ����ʦ����ְ�·�
SELECT t_name,t_entertime,EXTRACT(MONTH FROM t_entertime) FROM teacher to_char(t_entertime,'yyyy-mm-dd') LIKE '2007%'
--4.last_day����ȡĳ�����һ��
SELECT last_day(Sysdate) FROM dual;
--5.next_day����ȡ��ǰ����֮�����һ���ܼ�
SELECT next_day(SYSDATE,1) FROM dual;--ע���ܼ��ı�ʾϰ��
