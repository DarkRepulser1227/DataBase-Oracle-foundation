--创建班级表
CREATE TABLE banji (
--属性名称       字段类型     constraINT    约束名称    约束内容
b_id NUMBER                                 CONSTRAINT pk_b_id                         PRIMARY KEY,
b_name VARCHAR2(50)                 CONSTRAINT nn_b_name                  NOT NULL,
b_location VARCHAR2(10)             CONSTRAINT nn_b_location              NOT NULL
);
--查询用户表
SELECT     *                        FROM       User_Tables;
--查询约束信息
SELECT     *                        FROM       user_constraints;
--创建学生表
CREATE     TABLE  student    (
s_id  NUMBER(11)  CONSTRAINT  pk_s_id  PRIMARY KEY,--主键约束
s_name VARCHAR2(12)  CONSTRAINT  nn_s_name  NOT NULL,--非空约束
s_gender  VARCHAR2(6)  DEFAULT  'male'  CONSTRAINT  chk_s_gender  CHECK  (s_gender  IN  ('male','female')),--默认值和检查约束
s_idcard  VARCHAR2(18)  CONSTRAINT  uq_s_idcard  UNIQUE,--唯一约束
s_birthday  DATE  CONSTRAINT  nn_s_birthday  NOT NULL,
s_score  NUMBER(4,1)  DEFAULT  0  CONSTRAINT  chk_s_score  CHECK  (s_score BETWEEN  0  AND  100),--检查约束
s_banji_id  NUMBER  CONSTRAINT  fk_s_banji_id  REFERENCES banji(b_id)--外键约束
);

--查询制定表的约束信息
SELECT  *  FROM  User_Constraints  WHERE  table_name='STUDENT';  

--新建教师表
CREATE  TABLE  teacher (
t_id  NUMBER  PRIMARY  KEY,
t_name VARCHAR2(20)  NOT  NULL,
t_gender  VARCHAR2(6)  DEFAULT 'male' CHECK (t_gender IN ('male','female'))
);


--添加列
ALTER TABLE  banji  ADD  b_teacher_id  NUMBER  
--添加约束
CONSTRAINT fk_b_teacher_id  REFERENCES teacher(t_id);
--teacher表添加一列
ALTER  TABLE  teacher  ADD  t_birthday  DATE;
SELECT  *  FROM  teacher;
--删除列
ALTER TABLE banji  DROP  COLUMN  b_teacher_id;
--向班级表添加一列
ALTER  TABLE  banji  ADD  b_teacher_id  NUMBER;
--再添加外键约束
ALTER  TABLE  banji  ADD  FOREIGN  KEY(b_teacher_id)
REFERENCES  teacher(t_id);
SELECT  *  FROM  banji;
SELECT  *  FROM  User_Constraints WHERE  Table_Name='BANJI';

--修改列 alter  table  表名  modify  
--修改teacher表中的姓名字段的数据类型
ALTER  TABLE  teacher  MODIFY  t_name  VARCHAR2(200);
--修改约束
ALTER  TABLE  teacher  MODIFY  t_birthday  NOT NULL;
--查询列上的约束
SELECT  *  FROM  User_Cons_Columns  WHERE  table_name='TEACHER';
--修改默认值
ALTER  TABLE  teacher  MODIFY  t_gender  DEFAULT  'female';
--修改列名remame  column 
ALTER  TABLE  teacher  RENAME COLUMN t_name TO  T_name_new;
--重命名表名::rename...to...
RENAME  teacher  TO  TEA;
--删除表
CREATE  TABLE  test1(t_id  NUMBER);
DROP TABLE  test1;
--复习DDL
CREATE
ALTER  TABLE  table_name (ADD/MODIFY/DROP/RENAME)
DROP
RENAME


