--����ѯ
--������
SELECT * FROM stu;
SELECT * FROM banji;
SELECT * FROM tea;

SELECT t_id,t_name_new FROM tea,banji;--����������
--�����ӵ������﷨
--1.��where�Ӿ�ָ����������
SELECT t_id,t_name_new FROM tea,banji WHERE banji.B_TEACHER_ID=tea.T_ID AND b_name='������İ�';
--2����join on
SELECT t_id,t_name_new FROM tea JOIN banji ON banji.b_teacher_id=tea.t_id WHERE b_name='������İ�';
--3.join using(�������е�����������У����������ͬ���������ͺ��ֶ�����)
ALTER TABLE banji RENAME COLUMN b_teacher_id TO t_id;
SELECT t_id,t_name_new FROM tea JOIN banji USING (t_id) WHERE b_name='������İ�';
ALTER TABLE banji RENAME COLUMN t_id TO b_teacher_id;

--��ѯ�����һ���ѧ������Щ
SELECT s_name,s_id FROM banji INNER JOIN stu ON B_ID=s_BANJI_ID
WHERE b_name='�����һ��';

--��ѯ��ʦabc�İ༶���Ͽεص�
SELECT b_location,t_name_new FROM banji JOIN tea ON b_teacher_id=t_id WHERE t_name_new='abc'; 

--��ѯabc��ʦ���ڵİ༶������ƽ����
SELECT AVG(s_chn) FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
WHERE t_name_new='abc';

--��ѯ����ƽ����>60�ֵİ༶����ʦ���Ͽεص�
SELECT b_id FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
GROUP BY b_id HAVING AVG(s_chn)>60;

SELECT t_name_new,b_location FROM banji JOIN tea ON b_teacher_id=t_id
WHERE b_id IN(SELECT b_id FROM tea JOIN banji ON b_teacher_id=t_id JOIN stu ON b_id=s_banji_id 
GROUP BY b_id HAVING AVG(s_chn)>60);

--�����ӣ����⣨left outer�������⣨right outer����ȫ�⣨full outer����outer����ʡ��
--�������ӣ�����߱�Ϊ��׼
SELECT b_id,b_name,b_location,t_name_new FROM banji LEFT OUTER JOIN tea ON B_TEACHER_ID=t_id;
SELECT b_id,b_name,b_location,t_name_new FROM tea LEFT OUTER JOIN banji ON B_TEACHER_ID=t_id;
--�������ӣ����ұ߱�Ϊ��׼
SELECT b_id,b_name,b_location,t_name_new FROM banji RIGHT  OUTER JOIN tea ON B_TEACHER_ID=t_id;
SELECT b_id,b_name,b_location,t_name_new FROM tea RIGHT OUTER JOIN banji ON B_TEACHER_ID=t_id;
--ȫ������
SELECT b_id,b_name,b_location,t_name_new FROM tea FULL  OUTER JOIN banji ON B_TEACHER_ID=t_id;
--�����ӻ������üӺű�ʾ���Ӻŷ���û�м�¼���ͱ���Ϊ��ֵ��һ��
SELECT b_id,b_name,b_location,t_name_new FROM banji JOIN tea ON B_TEACHER_ID(+)=t_id;
--��Ȼ���ӣ�NATURAL ������������ֶ�����ͬ�������ͺ���ͬ���ֶ�����,���ӵ��ֶ����ƿ���ʡ��,Ч����ͬ�������ӣ�
ALTER TABLE banji RENAME COLUMN b_teacher_id TO t_id;
SELECT t_name_new,b_id FROM tea NATURAL JOIN banji;
--�ѿ��������� CROSS
SELECT t_name_new,b_id FROM tea CROSS JOIN banji;


--�������
--����union��union all
--��ѯ�������ĳɼ�>60��Ů����ѧ�ɼ�>80�ļ�¼
SELECT s_name,s_gender FROM stu
WHERE s_gender='male' AND s_chn>=60
UNION
SELECT s_name,s_gender,s_math FROM stu
WHERE s_gender='female' AND s_math>=80;

--union��union all������
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
UNION--ȥ���ظ�ֵ
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
UNION ALL--�򵥰Ѷ�����������һ��
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

--��:INTERSECT
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
INTERSECT --ȡ����������й�ͬ���ֵļ�¼
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;

--�
SELECT s_ID,s_name,s_gender FROM stu
WHERE  s_chn>=60
MINUS  --��ǰ��Ľ�����м�ȥ�����������ͬ�ļ�¼
SELECT S_ID,s_name,s_gender FROM stu
WHERE s_math>=80;
