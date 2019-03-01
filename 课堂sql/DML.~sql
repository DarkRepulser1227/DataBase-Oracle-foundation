--DML(insert,update,delete,select)
--insert:插入
--teacher->banji->student
SELECT  *  FROM  tea;
--向教师表插入记录
INSERT INTO tea  VALUES  (1,'abc','male',to_date('1980-01-01','yyyy-mm-dd'));
INSERT INTO tea  VALUES  (2,'bbb','female',to_date('1994-07-21','yyyy-mm-dd'));
INSERT INTO tea  VALUES  (3,'ccc','female',to_date('1990-11-08','yyyy-mm-dd'));
--修改教师表，增加手机和email属性
ALTER TABLE  tea  ADD  t_phone  VARCHAR2(11);
ALTER  TABLE  tea  ADD  t_email  VARCHAR2(64);
--选择性添加部分属性
INSERT  INTO  tea(t_id,t_name_new,t_gender,t_birthday) VALUES(4,'aaa','male',to_date('1989-10-18','yyyy-mm-dd'));
--一条语句插入多条记录
INSERT  ALL
INTO  tea  VALUES  (5,'ddd','female',to_date('1985-3-17','yyyy-mm-dd'),'','')
INTO  tea  VALUES  (6,'eee','male',to_date('1992-4-23','yyyy-mm-dd'),'','')
INTO  tea  VALUES  (7,'fff','male',to_date('1992-9-23','yyyy-mm-dd'),'','')
SELECT  *  FROM  dual;--daul:伪表
--向班级表插入3条记录
SELECT  *  FROM  banji;
INSERT  INTO  banji  VALUES(1,'计算机一班','301',1);
INSERT  INTO  banji  VALUES(2,'计算机二班','302',2);
INSERT  INTO  banji  VALUES(3,'计算机三班','303',3);
COMMIT;
INSERT  INTO  banji  VALUES(4,'计算机四班','304',4);
--向学生表插入信息
SELECT  *  FROM  student;
INSERT  INTO  student  VALUES(00001,'张三','male','310306199612270010',to_date('1992-9-23','yyyy-mm-dd'),'90',1);
INSERT  INTO  student  VALUES(00002,'张三','female','310306199612270011',to_date('1992-9-23','yyyy-mm-dd'),'70',2);
INSERT  INTO  student  VALUES(00003,'张三','male','310306199612270012',to_date('1992-9-23','yyyy-mm-dd'),'99',3);
INSERT  INTO  student  VALUES(00004,'张三','female','310306199612270013',to_date('1992-9-23','yyyy-mm-dd'),'92',1);
INSERT  INTO  student  VALUES(00005,'张三','male','310306199612270014',to_date('1992-9-23','yyyy-mm-dd'),'95',1);
INSERT  INTO  student  VALUES(00006,'张三','female','310306199612270015',to_date('1992-9-23','yyyy-mm-dd'),'60',1);
SELECT  *  FROM  User_Tab_Comments  WHERE  table_name='STUDENT';
--修改数据 update table name set....where
SELECT * FROM  tea;
UPDATE  tea  SET  t_phone='12345678989',t_email='abc@111';
UPDATE  tea  SET  t_phone='111' WHERE  t_id >= 5;
UPDATE  tea  SET  t_phone='222' WHERE  t_name_new='fff';
--删除记录  delete  from  table_name  where  ....
DELETE  FROM  tea  WHERE  t_id = 7;
--TRUNCATE删除表记录，效率高，但数据不能回滚
TRUNCATE  TABLE  student;
--外键约束中，删除数据的三种行为
--1) NO  Action : 默认，当引用表有记录时，不能删除被引用表的记录。
--2) Set  Null  :  当删除被引用表的记录时，引用当前记录的子记录自动设置为null
--3) Cascade  :  当删除被引用记录时，引用当前记录的子记录也被自动删除(级联删除)

--新建tea1表和banji1表
CREATE TABLE tea1 (
t_id NUMBER PRIMARY KEY,
t_name VARCHAR2(20) NOT NULL,
t_gender varchar2(6)DEFAULT 'male' CHECK(t_gender IN('male','female'))
);
CREATE TABLE banji1 (
b_id NUMBER PRIMARY KEY,
b_name VARCHAR2(50) NOT NULL,
b_location VARCHAR2(10)  NOT NULL
);
ALTER TABLE banji1 ADD b_teacher_id NUMBER REFERENCES tea1(t_id) ON DELETE SET NULL;
INSERT INTO tea1 VALUES(1,'aaa','male');
INSERT INTO tea1 VALUES(2,'bb','male');
INSERT INTO tea1 VALUES(3,'ccc','male');
COMMIT;
SELECT * FROM tea1;
INSERT INTO banji1 VALUES(1,'111','301',1);
INSERT INTO banji1 VALUES(2,'222','302',1);
INSERT INTO banji1 VALUES(3,'333','303',2);
INSERT INTO banji1 VALUES(4,'444','304',3);
COMMIT;
SELECT * FROM tea1;
SELECT * FROM banji1;
DELETE FROM tea1 WHERE t_id=1;



--新建tea1表和banji1(演示CASCADE)

CREATE TABLE tea2 (
t_id NUMBER PRIMARY KEY,
t_name VARCHAR2(20) NOT NULL,
t_gender varchar2(6)DEFAULT 'male' CHECK(t_gender IN('male','female'))
);
CREATE TABLE banji2 (
b_id NUMBER PRIMARY KEY,
b_name VARCHAR2(50) NOT NULL,
b_location VARCHAR2(10)  NOT NULL
);
ALTER TABLE banji2 ADD b_teacher_id NUMBER REFERENCES tea2(t_id) ON DELETE CASCADE;
INSERT INTO tea2 VALUES(1,'aaa','male');
INSERT INTO tea2 VALUES(2,'bb','male');
INSERT INTO tea2 VALUES(3,'ccc','male');
COMMIT;
SELECT * FROM tea2;
INSERT INTO banji2 VALUES(1,'111','301',1);
INSERT INTO banji2 VALUES(2,'222','302',1);
INSERT INTO banji2 VALUES(3,'333','303',2);
INSERT INTO banji2 VALUES(4,'444','304',3);
COMMIT;
SELECT * FROM tea2;
SELECT * FROM banji2;
DELETE FROM tea2 WHERE t_id=1;
