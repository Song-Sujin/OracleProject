--�� ���� ����
CREATE USER TEAM2 IDENTIFIED BY team2$admin;
--==>> User TEAM2��(��) �����Ǿ����ϴ�.

--�� ���� �ο�
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE, CREATE VIEW TO TEAM2;
--==>> Grant��(��) �����߽��ϴ�.

GRANT CREATE PROCEDURE TO TEAM2;