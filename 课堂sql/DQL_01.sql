--select ����ִ��˳��
--from->where->group by->having->select->distinct->order by  

--α��dual��ʹ��
SELECT 3+2 FROM  dual;
SELECT  *  FROM  student;
--��student���s_score������Ϊs_math
ALTER  TABLE  student  RENAME  COLUMN  s_score  TO  s_math;
--Ϊstudent����������ֶΣ�s_chn,s_eng
ALTER  TABLE  student  ADD  s_chn  NUMBER(4,1);
ALTER  TABLE  student  ADD  s_eng  NUMBER(4,1);
--Ϊstudent���������
UPDATE  student  SET s_chn=92,s_eng=95 WHERE s_id=1;
UPDATE  student  SET s_chn=72,s_eng=80 WHERE s_id=2;
UPDATE  student  SET s_chn=100,s_eng=100 WHERE s_id=3;
UPDATE  student  SET s_chn=87,s_eng=85 WHERE s_id=4;
UPDATE  student  SET s_chn=70,s_eng=60 WHERE s_id=5;
UPDATE  student  SET s_chn=50,s_eng=57 WHERE s_id=6;
--select�Ӿ����ѧ����
SELECT  s_math+s_chn+s_eng FROM student;
SELECT s_name,s_gender,s_math+s_chn+s_eng FROM student;
--Ϊ�������ñ���(as����ʡ��)
SELECT s_name,s_gender,s_math+s_chn+s_eng AS total FROM student;
SELECT s_name,s_gender,s_math+s_chn+s_eng       total FROM student;
--�ۺϺ��� count  sum  avg  max  min
SELECT COUNT(*)  FROM  student;
SELECT SUM(s_math),AVG (s_math) FROM student;
SELECT  MAX(s_math),MIN(s_math) FROM student;
--�ַ������������
SELECT '����Ϊ��' || COUNT(*)  FROM  student;
SELECT '����Ϊ��' || s_name FROM  student;
--where�Ӿ�
SELECT *  FROM  student WHERE  s_math<60;
SELECT *  FROM  student WHERE  s_math>=60;
SELECT *  FROM  student WHERE  s_math=99;
SELECT *  FROM  student WHERE  s_math!=99;--<>

--where�Ӿ��е��߼����㣨and, or, not��
SELECT  *  FROM  student  WHERE  s_math>=70  AND  s_math<80;
SELECT  *  FROM  student  WHERE  s_math<70  OR  s_math>=80;
--ʹ��between...and...(������)
SELECT  *  FROM  student  WHERE  s_math  BETWEEN 90  AND  100;
--in  ��  not  in
SELECT  *  FROM  student WHERE  s_id  IN(1,2,5);
SELECT  *  FROM  student WHERE  s_id  NOT  IN(1,2,5);
--ģ����ѯ
--����ͨ���1.%(�������������ַ�) 2. _(һ�������ַ�)
--��ѯ���к�����ĸa��ѧ��
--like  ��  not  like
SELECT  *  FROM student  WHERE s_name  LIKE  '%��%';
SELECT  *  FROM student  WHERE s_name  NOT  LIKE  '%��%';
--��ѯ����Ϊ��ĸa��Ͷ��������3���ַ����ɵ�����
SELECT  *  FROM  student  WHERE  s_name LIKE  'a__';
SELECT  *  FROM  student  WHERE  s_name NOT LIKE  'a__';
--��ѯ1992��9�³�����ѧ��
SELECT  *  FROM  student  WHERE  to_char(s_birthday,'yyyy-mm-dd') LIKE  '1992-09%';
--is null  ��  is  not  null
--��ѯ��ʦ���е绰Ϊ��ֵ����
INSERT  INTO  tea(t_id,t_name_new,t_gender,t_birthday)
VALUES  (8,'ggg','male',to_date('1996-01-01','yyyy-mm-dd'));
SELECT *  FROM  tea  WHERE  t_phone IS NULL;
SELECT *  FROM  tea  WHERE  t_phone IS NOT NULL;
--distinct �ؼ��� ��ȥ���ظ���
SELECT  s_banji_id FROM  student;
SELECT DISTINCT  s_banji_id FROM student;
--α��
--rownum:�ѷ��������ļ�¼��һ��ʼ���
--rowid���е�id�ţ������ڹ�ϣ��
SELECT  s_name,s_gender,s_math  FROM  student WHERE  s_gender='male';
SELECT  rownum,rowid,s_name,s_gender,s_math  FROM  student WHERE  s_gender='male';
--������top��liimit�Ĺ���
SELECT  s_id,s_name,s_math FROM  studen  ORDER  BY  s_math DESC;
--�Ӳ�ѯ
SELECT ROWNUM,s_id,s_name,s_math 
FROM (SELECT  s_id,s_name,s_math FROM  student  ORDER  BY  s_math DESC)
WHERE  rownum<=3  ORDER BY  ROWNUM;
--group by ;����
--���հ༶��ѯ�����༶����ѧƽ����
SELECT s_banji_id,AVG(s_math)  FROM  student GROUP BY  s_banji_id;
--SELECT s_banji_id,AVG(s_math)  FROM  student GROUP BY  s_gender;
SELECT s_gender,AVG(s_math)  FROM  student GROUP BY  s_gender;
--having���������group by
--��ѯ�༶��ѧƽ���ּ���İ༶����Щ��
SELECT s_banji_id,AVG(s_math)
FROM student 
GROUP BY s_banji_id HAVING AVG(s_math)>=60;
--order by ,�������ö�����ؼ���
--������ѧ�ɼ���������(ASC)
SELECT *  FROM student ORDER BY s_math;
--������ѧ�ɼ���������,�����ѧ�ɼ���ͬ���������ĳɼ�����
SELECT *  FROM student ORDER BY s_math,s_chn;
--����
SELECT *  FROM student ORDER BY s_math DESC ,s_chn DESC;
--��ѯ�����༶���������Ƴɼ��ֲܷ����ֵܷ�ƽ���ִ���180�ֵ�ѧ�����������ֽܷ���
SELECT  s_banji_id,avg(s_math+s_chn+s_eng) FROM student 
WHERE  s_gender='male'
GROUP BY s_banji_id 
HAVING avg(s_math+s_chn+s_eng) >=180
ORDER BY avg(s_math+s_chn+s_eng) DESC;
