--1.�Ӳ�ѯ
--����ʹ�õ������   in��any��some����all
SELECT * FROM stu;
SELECT * FROM banji;
--��ѯ�����һ��ѧ������Щ
SELECT b_id FROM banji WHERE b_name='�����һ��';
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT b_id FROM banji WHERE b_name='�����һ��');
--��ѯ��wangwuͬ�༶������ѧ��
SELECT s_banji_id FROM stu WHERE s_name='wangwu';
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT s_banji_id FROM stu WHERE s_name='wangwu');

--��ѯ������ͬ�ಢ���Ա���ͬ��ѧ������Щ
SELECT s_gender,s_banji_id FROM stu WHERE s_name='zhangsan';
SELECT * FROM stu 
WHERE (s_gender,s_banji_id)=(SELECT s_gender,s_banji_id FROM stu WHERE s_name='zhangsan');


--�Ӳ�ѯҲ���Գ�����from֮��,��ʹ��rownum��ѯtopǰ����
--�Ӳ�ѯ�ɿ��Գ�����select��
--ͨ��һ����ѯ��䣬��ѯ��ʦ��������ѧ��������
SELECT COUNT(*) AS �������� FROM tea;
SELECT COUNT(*) AS ѧ������ FROM stu;
SELECT (SELECT COUNT(*) FROM tea) AS ��ʦ������(SELECT COUNT(*) FROM stu) AS ѧ������
FROM dual; 
--��ѯ������Ϊabc��ѧ������Щ
SELECT t_id FROM tea WHERE t_name_new='abc';
SELECT b_id FROM banji WHERE B_TEACHER_ID=(SELECT t_id FROM tea WHERE t_name_new='abc');
SELECT s_name,s_banji_id FROM stu 
WHERE s_banji_id=(SELECT b_id FROM banji WHERE B_TEACHER_ID=(SELECT t_id FROM tea WHERE t_name_new='abc'));
--�������in
--��ѯ��301��302�Ͽε�ѧ������Щ
SELECT b_id FROM banji WHERE b_location IN ('301','302');
SELECT s_name,s_banji_id FROM stu
WHERE s_banji_id  IN (SELECT b_id FROM banji WHERE b_location IN ('301','302'));
--any ��some����һ�����������Ϳ���,��any֮ǰ����ʹ�õ��в�����
--��ѯ��ѧ�ɼ���������һ���༶����ѧ�ɼ�ƽ���ֵ�ѧ��
SELECT s_banji_id,AVG(s_math) FROM stu GROUP BY s_banji_id;
SELECT s_name,s_banji_id,s_math FROM stu
WHERE s_math > ANY(SELECT AVG(s_math) FROM stu GROUP BY s_banji_id);

--all����Ҫ����
--��ѯ��Щѧ������ѧ�ɼ��������а༶����ѧƽ���ֻ�Ҫ�ߵ�ѧ��
SELECT s_name,s_banji_id,s_math FROM stu
WHERE s_math > ALL (SELECT AVG(s_math) FROM stu GROUP BY s_banji_id);

--�Ӳ�ѯ������insert��update��delete��
--1��insert
--�����±�tea_female, ��Ů��ʦ��id�������ŵ��±���
CREATE TABLE tea_female (t_id NUMBER,t_name VARCHAR2(20));
SELECT t_id,t_name_new FROM tea WHERE t_gender='female';
INSERT INTO tea_female (SELECT t_id,t_name_new FROM tea WHERE t_gender='female');
SELECT * FROM tea_female;

--2)update
--�Ѻ�zhangsanͬ���ѧ������ѧ�ɼ����10%

SELECT s_banji_id FROM stu WHERE s_name='zhangsan';
UPDATE stu SET s_math=s_math*1.1
WHERE s_banji_id=(SELECT s_banji_id FROM stu WHERE s_name='zhangsan');
COMMIT;
SELECT * FROM stu;

--3)delete�����
--����������ѧ�ɼ�һ����ѧ���ļ�¼ɾ��
SELECT s_math FROM stu WHERE s_name='zhangsan';
DELETE FROM stu
WHERE s_math = (SELECT s_math FROM stu WHERE s_name='zhangsan');
COMMIT;

