��8.1��ʹ��COMMIT������������ύ
--��SQL*Plus�ͻ��ˣ��Ự1��
SQL> CREATE TABLE test(id NUMBER PRIMARY KEY, name VARCHAR2(10));
SQL> INSERT INTO test VALUES(1, '����');
SQL> COMMIT;
SQL> INSERT INTO test VALUES(2, '����');
SQL> CREATE VIEW v_test AS SELECT * FROM test;
--�ٴ���һ��SQL*Plus�ͻ��ˣ��Ự2��
SQL> SELECT id, name FROM test;
SQL> SELECT id, name FROM test;
SQL> SELECT id, name FROM test; 
SQL> SELECT id, name FROM test;

��8.2��ʹ��ROLLBACK���ͱ���㼼���������Ĳ��ֻع�����ȫ�ع�
--������8.1
SQL> INSERT INTO test VALUES(3, '����');
SQL> SAVEPOINT a;
SQL> INSERT INTO test VALUES(4, '����');
SQL> SAVEPOINT b;
SQL> INSERT INTO test VALUES(5, 'Ǯ��');
SQL> SELECT id, name FROM test;    
SQL> ROLLBACK TO SAVEPOINT a; 
SQL> SELECT id, name FROM test;
SQL> ROLLBACK TO SAVEPOINT b; 
SQL> ROLLBACK;
