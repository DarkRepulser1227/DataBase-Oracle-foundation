例8.1：使用COMMIT语句完成事务的提交
--打开SQL*Plus客户端（会话1）
SQL> CREATE TABLE test(id NUMBER PRIMARY KEY, name VARCHAR2(10));
SQL> INSERT INTO test VALUES(1, '张三');
SQL> COMMIT;
SQL> INSERT INTO test VALUES(2, '李四');
SQL> CREATE VIEW v_test AS SELECT * FROM test;
--再打开另一个SQL*Plus客户端（会话2）
SQL> SELECT id, name FROM test;
SQL> SELECT id, name FROM test;
SQL> SELECT id, name FROM test; 
SQL> SELECT id, name FROM test;

例8.2：使用ROLLBACK语句和保存点技术完成事务的部分回滚和完全回滚
--延续例8.1
SQL> INSERT INTO test VALUES(3, '王五');
SQL> SAVEPOINT a;
SQL> INSERT INTO test VALUES(4, '赵六');
SQL> SAVEPOINT b;
SQL> INSERT INTO test VALUES(5, '钱七');
SQL> SELECT id, name FROM test;    
SQL> ROLLBACK TO SAVEPOINT a; 
SQL> SELECT id, name FROM test;
SQL> ROLLBACK TO SAVEPOINT b; 
SQL> ROLLBACK;
