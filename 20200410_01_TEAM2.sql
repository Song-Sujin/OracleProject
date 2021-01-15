-- ��� ����

-- ���� ���� ���� �Ǻ� ��� : ���±�
CREATE OR REPLACE FUNCTION OS_ING
(
  OS_START IN TBL_OPEN_SUB.OPSUB_START%TYPE
, OS_END IN TBL_OPEN_SUB.OPSUB_END%TYPE
)
RETURN VARCHAR2
IS
    SD TBL_OPEN_SUB.OPSUB_START%TYPE;
BEGIN
    SELECT SYSDATE INTO SD
    FROM DUAL;
    
    IF(OS_START <= SD AND OS_END >= SD)
        THEN RETURN '���� ��';
    ELSIF(OS_START > SD)
        THEN RETURN '���� ����';
    ELSIF(OS_END < SD)
        THEN RETURN '���� ����';
    END IF;
    
    RETURN '��';
END;



-- ���� ���� ���� FUCTION : ������
CREATE OR REPLACE FUNCTION SCORE_TOT
( V_SCO_ATD IN TBL_SCORE.SCO_ATD%TYPE
, V_SCO_PRC IN TBL_SCORE.SCO_PRC%TYPE
, V_SCO_WRT IN TBL_SCORE.SCO_WRT%TYPE
)
RETURN NUMBER
IS
    V_TOT   NUMBER;
BEGIN
    V_TOT := V_SCO_ATD + V_SCO_PRC + V_SCO_WRT;
    
    RETURN V_TOT;
END;
--==>> Function SCORE_TOT��(��) �����ϵǾ����ϴ�.



--------------------------------------------------------------------------------------
-- ���� ���̺� INSERT ���ν���


-- ����INSERT ���ν��� : �ۼ���
CREATE OR REPLACE PROCEDURE PRC_CRS_INSERT
( V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE
)
IS
BEGIN
    INSERT INTO TBL_COURSE(CRS_CD, CRS_NAME)
    VALUES('CR' || LPAD(SEQ_COURSE.NEXTVAL, 3, 0), V_CRS_NAME);
    
    COMMIT;
END;
--==>> Procedure PRC_CRS_INSERT��(��) �����ϵǾ����ϴ�.

-- ����INSERT ���ν��� : ���Ѻ�
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUB_NAME IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS
BEGIN

    INSERT INTO TBL_SUBJECT(SUB_CD, SUB_NAME) 
    VALUES ('SB' || LPAD(SEQ_SUBJECT.NEXTVAL, 3, 0), V_SUB_NAME);
    
    COMMIT;
END;
--==>> Procedure PRC_SUBJECT_INSERT��(��) �����ϵǾ����ϴ�.


-- ���ǽ� INSERT ���ν��� : ������
CREATE OR REPLACE PROCEDURE PRC_CLS_INSERT
( V_CLS_INFO    IN TBL_CLASS.CLS_INFO%TYPE)
IS
BEGIN
    INSERT INTO TBL_CLASS(CLS_CD, CLS_INFO)
    VALUES('CL' || LPAD(SEQ_CLASS.NEXTVAL, 3, 0), V_CLS_INFO);
    
    COMMIT;
END;
--==>> Procedure PRC_CLS_INSERT��(��) �����ϵǾ����ϴ�.

-- ���� INSERT ���ν��� : ����ȭ
CREATE OR REPLACE PROCEDURE PRC_BK_INSERT
( V_BK_TITLE IN TBL_BOOK.BK_TITLE%TYPE
, V_BK_INFO IN TBL_BOOK.BK_INFO%TYPE
)
IS
BEGIN
    INSERT INTO TBL_BOOK(BK_CD, BK_TITLE, BK_INFO) 
    VALUES ('BK' || LPAD(SEQ_BOOK.NEXTVAL, 3, 0), V_BK_TITLE, V_BK_INFO);
    
    COMMIT;
END;
--==>> Procedure PRC_BK_INSERT��(��) �����ϵǾ����ϴ�.


-- ������ INSERT ���ν��� : ���±�
CREATE OR REPLACE PROCEDURE PRC_PRO_INSERT
( I_ID IN TBL_PROFESSOR.PRO_ID%TYPE
, I_NAME IN TBL_PROFESSOR.PRO_NAME%TYPE
, I_SSN IN TBL_PROFESSOR.PRO_SSN%TYPE)
IS
BEGIN
    INSERT INTO TBL_PROFESSOR (PRO_ID, PRO_NAME, PRO_PW, PRO_SSN)
    VALUES('P' || LPAD(SEQ_PROFESSOR.NEXTVAL, 3, 0), I_NAME, I_SSN, I_SSN);
    
    COMMIT;
END;
--==>> Procedure PRC_PRO_INSERT��(��) �����ϵǾ����ϴ�.

-- �л� INSERT ���ν��� : ������
CREATE OR REPLACE PROCEDURE PRC_STU_INSERT
( V_STU_ID IN TBL_STUDENT.STU_ID%TYPE
, V_STU_NAME IN TBL_STUDENT.STU_NAME%TYPE
, V_STU_SSN IN TBL_STUDENT.STU_SSN%TYPE)
IS
BEGIN
    INSERT INTO TBL_STUDENT(STU_ID, STU_NAME, STU_PW, STU_SSN)
    VALUES('S' || TO_CHAR(SYSDATE, 'YYYY') || LPAD(SEQ_STUDENT.NEXTVAL, 5, 0), V_STU_NAME, V_STU_SSN, V_STU_SSN);
    
    COMMIT;
END;
--==>> Procedure PRC_STU_INSERT��(��) �����ϵǾ����ϴ�.


------------------------------------------------------------------------------------------------------
-- ���� ���̺� UPDATE ���ν���

-- ���� UPDATE ���ν��� : �ۼ���
CREATE OR REPLACE PROCEDURE PRC_CRS_UPDATE
( V_CRS_NAME_BF    IN TBL_COURSE.CRS_NAME%TYPE
, V_CRS_NAME_AF    IN TBL_COURSE.CRS_NAME%TYPE
)
IS
BEGIN
    
    UPDATE TBL_COURSE
    SET CRS_NAME = V_CRS_NAME_AF
    WHERE CRS_NAME = V_CRS_NAME_BF;
    
    COMMIT;
END;
--==>> Procedure PRC_CRS_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���ǽ� UPDATE ���ν��� : ������
CREATE OR REPLACE PROCEDURE PRC_CLS_UPDATE
( V_CLS_INFO_BF      IN TBL_CLASS.CLS_INFO%TYPE
, V_CLS_INFO_AF      IN TBL_CLASS.CLS_INFO%TYPE)
IS
BEGIN
    UPDATE TBL_CLASS
    SET   CLS_INFO = V_CLS_INFO_AF
    WHERE CLS_CD = V_CLS_INFO_BF;
    
    COMMIT;
END;
--==>> Procedure PRC_CLS_UPDATE��(��) �����ϵǾ����ϴ�.



--���� ���� ���� (�����ڰ� �̸�����) : ���±�
CREATE OR REPLACE PROCEDURE PRC_PRO_UPNAME
( I_ID IN TBL_PROFESSOR.PRO_ID%TYPE
, I_NAME IN TBL_PROFESSOR.PRO_NAME%TYPE)
IS
BEGIN
    UPDATE TBL_PROFESSOR
    SET PRO_NAME = I_NAME
    WHERE PRO_ID = I_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_PRO_UPNAME��(��) �����ϵǾ����ϴ�.


--���� ��й�ȣ �ʱ�ȭ (�����ڰ� ��� �ʱ�ȭ) : ���±�
CREATE OR REPLACE PROCEDURE PRC_PRO_RESET
(I_ID IN TBL_PROFESSOR.PRO_ID%TYPE)
IS
BEGIN
    UPDATE TBL_PROFESSOR
    SET PRO_PW = PRO_SSN
    WHERE PRO_ID = I_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_PRO_RESET��(��) �����ϵǾ����ϴ�.

--���� ��й�ȣ ���� (������ �������) : ���±�
CREATE OR REPLACE PROCEDURE PRC_PRO_UPPW
(I_ID IN TBL_PROFESSOR.PRO_ID%TYPE
, I_PASS IN TBL_PROFESSOR.PRO_PW%TYPE)
IS
BEGIN
    UPDATE TBL_PROFESSOR
    SET PRO_PW = I_PASS
    WHERE PRO_ID = I_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_PRO_UPPW��(��) �����ϵǾ����ϴ�.


-- ���� UPDATE ���ν��� : ���Ѻ�
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_UPDATE
( V_SUB_NAME_BF IN TBL_SUBJECT.SUB_NAME%TYPE
 ,V_SUB_NAME_AF IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS
BEGIN
    UPDATE TBL_SUBJECT
    SET   SUB_NAME = V_SUB_NAME_AF
    WHERE SUB_NAME = V_SUB_NAME_BF;
    
    COMMIT;
END;
--==>> Procedure PRC_SUBJECT_UPDATE��(��) �����ϵǾ����ϴ�.


-- ���� UPDATE : ����ȭ

CREATE OR REPLACE PROCEDURE PRC_BK_UPDATE
( V_BK_CD       IN TBL_BOOK.BK_CD%TYPE      -- EXEC �Էµ� ������ �����ڵ�
, V_BK_TITLE    IN TBL_BOOK.BK_TITLE%TYPE   -- EXEC �Էµ� ����� �����
, V_BK_INFO     IN TBL_BOOK.BK_INFO%TYPE    -- EXEC �Էµ� ����� ��������
)
IS
    USER_DEFINE_ERROR  EXCEPTION;          -- ���� �Է�(�����ڵ尡 ��Ī���� ���� ���)
BEGIN
    -- ����� ���������� �Է����� �ʾ����� (������ �����ڵ�, ����� �����)
    IF (V_BK_INFO IS NULL AND V_BK_TITLE IS NOT NULL AND V_BK_INFO IS NOT NULL)
        THEN
        -- ����� ����
        UPDATE TBL_BOOK             -- ���� ���̺���
        SET BK_TITLE=V_BK_TITLE   -- ���� ������� ���ο� ��������� ����
        WHERE BK_CD=V_BK_CD;        -- �����ڵ尡 ������ �����ڵ�� ���� ���
    
    -- ����� ������� �Է����� �ʾ����� (������ �����ڵ�, ����� ��������)
    ELSIF (V_BK_TITLE IS NULL AND V_BK_TITLE IS NOT NULL)
        THEN
        -- ���������� ����
        UPDATE TBL_BOOK             -- ���� ���̺���
        SET BK_INFO=V_BK_INFO       -- ���� ���������� ���ο� ���������� ����
        WHERE BK_CD=V_BK_CD;        -- �����ڵ尡 ������ �����ڵ�� ���� ���
    
    -- ������ �������� ��� �Է����� ���(������ �����ڵ�, ����� �����, ����� ��������)
    ELSE
        -- ��� ����
        UPDATE TBL_BOOK                                 -- ���� ���̺���
        SET BK_TITLE=V_BK_TITLE, BK_INFO=V_BK_INFO    -- ���� ������� ���ο� ��������� ����, ���� ���������� ���ο� ���������� ����
        WHERE BK_CD=V_BK_CD;                            -- �����ڵ尡 ������ �����ڵ�� ���� ���
    END IF;
    
    COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20005, 'ERROR : ��ġ�ϴ� �����ڵ尡 �������� �ʽ��ϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_BK_UPDATE��(��) �����ϵǾ����ϴ�.



-- �л� �̸� ���� (�����ڰ� �̸��� ����) : ������
CREATE OR REPLACE PROCEDURE PRC_STU_UPNAME
( V_STU_NAME IN TBL_STUDENT.STU_NAME%TYPE
, V_STU_ID   IN TBL_STUDENT.STU_ID%TYPE)
IS
BEGIN 
    UPDATE TBL_STUDENT
    SET STU_NAME = V_STU_NAME
    WHERE STU_ID = V_STU_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_STU_UPNAME��(��) �����ϵǾ����ϴ�.


-- �л� ��й�ȣ ���� (�л�) : ������
CREATE OR REPLACE PROCEDURE PRC_STU_UPPW
( V_STU_ID   IN TBL_STUDENT.STU_ID%TYPE
, V_STU_PW   IN TBL_STUDENT.STU_PW%TYPE)
IS
BEGIN 
    UPDATE TBL_STUDENT
    SET STU_PW = V_STU_PW
    WHERE STU_ID = V_STU_ID;
    
    COMMIT;

END;
--==>> Procedure PRC_STU_UPPW��(��) �����ϵǾ����ϴ�.


-- �л� ��й�ȣ �ʱ�ȭ (������) : ������
CREATE OR REPLACE PROCEDURE PRC_STU_RESET
( V_STU_ID  IN TBL_STUDENT.STU_ID%TYPE)
IS
BEGIN
    UPDATE TBL_STUDENT
    SET STU_PW = STU_SSN
    WHERE STU_ID = V_STU_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_STU_RESET��(��) �����ϵǾ����ϴ�.

------------------------------------------------------------------------------------------------------
-- ���� ���̺� DELETE ���ν���

-- ���� ���� ���� : ���±�
CREATE OR REPLACE PROCEDURE PRC_PRO_DELETE
(I_ID IN TBL_PROFESSOR.PRO_ID%TYPE)
IS
BEGIN
    DELETE
    FROM TBL_PROFESSOR
    WHERE PRO_ID = I_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_PRO_DELETE��(��) �����ϵǾ����ϴ�.

-- �л� ���� ���� : ������
CREATE OR REPLACE PROCEDURE PRC_STU_DELETE
( V_STU_ID IN TBL_STUDENT.STU_ID%TYPE
)
IS
BEGIN
    DELETE
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    COMMIT;
END;
--==>> Procedure PRC_STU_DELETE��(��) �����ϵǾ����ϴ�.


-- ���� DELETE ���ν��� : ���Ѻ�
CREATE OR REPLACE PROCEDURE PRC_SUB_DELETE
( V_SUB_NAME IN TBL_SUBJECT.SUB_CD%TYPE
)
IS
BEGIN
    DELETE
    FROM TBL_SUBJECT
    WHERE SUB_NAME = V_SUB_NAME;
    
    COMMIT;
END;
--==>> Procedure PRC_SUB_DELETE��(��) �����ϵǾ����ϴ�.


-- ���� ���� ���(������) : ����ȭ
-- ������� �Է��ϸ�, ������� �����ϰų�, ������ ���������� ���ÿ� �����Ѵ�.
-- ������ ������, ����� ���� �ʰ� ���� ���̺����� NULL�� ǥ��ȴ�.
CREATE OR REPLACE PROCEDURE PRC_BK_DELETE
( V_BK_TITLE       IN TBL_BOOK.BK_CD%TYPE      -- EXEC �Էµ� ������ �����ڵ�
)
IS
BEGIN
    -- ��� ����
    DELETE                  -- ����
    FROM TBL_BOOK           -- ���� ���̺���
    WHERE BK_TITLE = V_BK_TITLE;    -- �����ڵ尡 ������ �����ڵ�� ���� ���
    
    COMMIT;
END;


-- ���� DELETE ���ν��� : �ۼ���
CREATE OR REPLACE PROCEDURE PRC_CRS_DELETE
( V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE
)
IS
BEGIN
    DELETE
    FROM TBL_COURSE
    WHERE CRS_NAME = V_CRS_NAME;
    
    COMMIT;
END;
--==>> Procedure PRC_CRS_DELETE��(��) �����ϵǾ����ϴ�.


-- ���ǽ� ���� ���� : ������
CREATE OR REPLACE PROCEDURE PRC_CLS_DELETE
( V_CLS_CD IN TBL_CLASS.CLS_CD%TYPE)
IS
BEGIN
    DELETE
    FROM TBL_CLASS
    WHERE CLS_CD = V_CLS_CD;
    
    COMMIT;
END;
--==>> Procedure PRC_CLS_DELETE��(��) �����ϵǾ����ϴ�.


-----------------------------------------------------------------------------------------------
-- ���� ���̺� INSERT 

--���� ���� ��� : ���±�
CREATE OR REPLACE PROCEDURE PRC_OPSUB_INSERT
( I_SUB_NAME IN TBL_SUBJECT.SUB_NAME%TYPE
, I_BK_TITLE IN TBL_BOOK.BK_TITLE%TYPE
, OPCRS_NO IN TBL_OPEN_CRS.OPCRS_NUM%TYPE
, START_DATE VARCHAR2, END_DATE VARCHAR2)
IS
    SB_NO TBL_SUBJECT.SUB_CD%TYPE;
    BK_NO TBL_BOOK.BK_CD%TYPE;
BEGIN
    SELECT SUB_CD INTO SB_NO
    FROM TBL_SUBJECT
    WHERE SUB_NAME = I_SUB_NAME;
    
    SELECT BK_CD INTO BK_NO
    FROM TBL_BOOK
    WHERE BK_TITLE = I_BK_TITLE;

    INSERT INTO TBL_OPEN_SUB(OPSUB_NUM, SUB_CD, BK_CD, OPCRS_NUM, OPSUB_START, OPSUB_END) 
    VALUES(SEQ_OPEN_SUB.NEXTVAL, SB_NO, BK_NO, OPCRS_NO, TO_DATE(START_DATE), TO_DATE(END_DATE));
    
    COMMIT;
END;
--==>> Procedure PRC_OPSUB_INSERT��(��) �����ϵǾ����ϴ�.


-- �������� INSERT ���ν��� : ���Ѻ�, ����ȭ
CREATE OR REPLACE PROCEDURE PRC_OPCRS_INSERT
( V_OPCRS_START IN VARCHAR2 -- INSERT �������� DATE Ÿ������ ��ȯ
, V_OPCRS_END   IN VARCHAR2
, V_OPCRS_DATE  IN VARCHAR2

-- �� ����, ������, ���ǽǸ� �޾ƿ���
, V_CRS_NAME   IN TBL_COURSE.CRS_NAME%TYPE
, V_PRO_NAME   IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_CLS_CD     IN TBL_CLASS.CLS_CD%TYPE
)
IS
    V_CRS_CD    TBL_COURSE.CRS_CD%TYPE;
    V_PRO_ID    TBL_PROFESSOR.PRO_ID%TYPE;
    
    -- EXCEPTION
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ���� ���(V_CRS_CD)
    SELECT CRS_CD INTO V_CRS_CD
    FROM TBL_COURSE
    WHERE CRS_NAME = V_CRS_NAME;
    
    -- ���� ���(V_PRO_ID)
    SELECT PRO_ID INTO V_PRO_ID
    FROM TBL_PROFESSOR
    WHERE PRO_NAME = V_PRO_NAME;
    
    -- EXCEPTION �߻���Ű��
    IF(TO_DATE('V_OPCRS_DATE','YYYY-MM-DD')>TO_DATE('V_OPCRS_START', 'YYYY-MM-DD'))
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    INSERT INTO TBL_OPEN_CRS(OPCRS_NUM,CRS_CD, PRO_ID, CLS_CD, OPCRS_START, OPCRS_END, OPCRS_DATE)
    VALUES (SEQ_OPEN_CRS.NEXTVAL, V_CRS_CD, V_PRO_ID, V_CLS_CD
          , TO_DATE('V_OPCRS_START', 'YYYY-MM-DD'),TO_DATE('V_OPCRS_END', 'YYYY-MM-DD'),TO_DATE('V_OPCRS_DATE','YYYY-MM-DD'));
    
    COMMIT;

EXCEPTION
        WHEN USER_DEFINE_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20004, 'ERROR : ���� �������� ���� ������ �����Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_OPCRS_INSERT��(��) �����ϵǾ����ϴ�.


---------------------------------------------------------------------------------------------
-- ���� ���̺� UPDATE 

-- ��������_DATE UPDATE ���ν��� : ���Ѻ�
CREATE OR REPLACE PROCEDURE PRC_OPCRS_UPDATE
( V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE
, V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
, V_CLS_CD      IN TBL_CLASS.CLS_CD%TYPE
, V_OPCRS_START VARCHAR2
, V_OPCRS_END   VARCHAR2
, V_OPCRS_DATE  VARCHAR2
-- �Ǻ��� ���� PK��
, V_OPCRS_NUM   IN TBL_OPEN_CRS.OPCRS_NUM%TYPE
)
IS
 V_CRS_CD   TBL_COURSE.CRS_CD%TYPE;
 USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- ���� ä���(V_CRS_CD)
    SELECT CRS_CD INTO V_CRS_CD
    FROM TBL_COURSE
    WHERE CRS_NAME = V_CRS_NAME;
    
    -- EXCEPTION �߻���Ű��
    IF(TO_DATE('V_OPCRS_DATE','YYYY-MM-DD')>TO_DATE('V_OPCRS_START', 'YYYY-MM-DD'))
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_OPEN_CRS
    SET CRS_CD = V_CRS_CD, PRO_ID = V_PRO_ID, CLS_CD = V_CRS_CD
        , OPCRS_START =V_OPCRS_START, OPCRS_END = V_OPCRS_END, OPCRS_DATE = V_OPCRS_DATE
    WHERE OPCRS_NUM = V_OPCRS_NUM;
    
    COMMIT;

EXCEPTION
        WHEN USER_DEFINE_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20004, 'ERROR : ���� �������� ���� ������ �����Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;



--���� ���� �������� (������) : ���±�
CREATE OR REPLACE PROCEDURE PRC_OPSUB_UPRATE
( OPSUB_NO IN TBL_OPEN_SUB.OPSUB_NUM%TYPE
, I_ATD IN TBL_OPEN_SUB.ATD_RATE%TYPE
, I_PRC IN TBL_OPEN_SUB.PRC_RATE%TYPE
, I_WRT IN TBL_OPEN_SUB.WRT_RATE%TYPE)
IS
BEGIN
    UPDATE TBL_OPEN_SUB
    SET ATD_RATE = I_ATD, PRC_RATE = I_PRC, WRT_RATE = I_WRT
    WHERE OPSUB_NUM = OPSUB_NO;
    
    COMMIT;
END;
--==>> Procedure PRC_OPSUB_UPRATE��(��) �����ϵǾ����ϴ�.


-- ���� ���� : ������
CREATE OR REPLACE PROCEDURE PRC_SCO_UPDATE
( V_SCO_NUM IN TBL_SCORE.SCO_NUM%TYPE
, V_SCO_ATD IN TBL_SCORE.SCO_ATD%TYPE
, V_SCO_PRC IN TBL_SCORE.SCO_PRC%TYPE
, V_SCO_WRT IN TBL_SCORE.SCO_WRT%TYPE
)
IS
BEGIN
    UPDATE TBL_SCORE
    SET SCO_ATD = V_SCO_ATD, SCO_PRC = V_SCO_PRC, SCO_WRT = V_SCO_WRT
    WHERE SCO_NUM = V_SCO_NUM;
    
    COMMIT;
END;


-----------------------------------------------------------------------------------------------
-- ���� ���̺� DELETE

--���� ���� ���� : ���±�
CREATE OR REPLACE PROCEDURE PRC_OPSUB_DELETE
(OPSUB_NO IN TBL_OPEN_SUB.OPSUB_NUM%TYPE)
IS
BEGIN
    DELETE
    FROM TBL_OPEN_SUB
    WHERE OPSUB_NUM = OPSUB_NO;
    
    COMMIT;
END;
--==>> Procedure PRC_OPSUB_DELETE��(��) �����ϵǾ����ϴ�.

-- �������� ���� ���(������) : ����ȭ
CREATE OR REPLACE PROCEDURE PRC_OPCRS_DELETE
( V_OPCRS_NUM       IN TBL_OPEN_CRS.OPCRS_NUM%TYPE      -- EXEC �Էµ� ������ ������ȣ
)
IS
BEGIN
    -- ��� ����
    DELETE                          -- ����
    FROM TBL_OPEN_CRS               -- �������� ���̺���
    WHERE OPCRS_NUM=V_OPCRS_NUM;    -- ������ȣ�� ������ ������ȣ�� ���� ���
    
    COMMIT;
END;
--==>> Procedure PRC_OPCRS_DELETE��(��) �����ϵǾ����ϴ�.

-- ���� ���� ���� : ������
CREATE OR REPLACE PROCEDURE PRC_SCO_DELETE
( V_SCO_NUM IN TBL_SCORE.SCO_NUM%TYPE)
IS
BEGIN
    DELETE
    FROM TBL_SCORE
    WHERE SCO_NUM = V_SCO_NUM;
    
    COMMIT;
END;
--==>> Procedure PRC_SCO_DELETE��(��) �����ϵǾ����ϴ�.

----------------------------------------------------------------------------------------------------

-- ���� INSERT ���ν���
CREATE OR REPLACE PROCEDURE PRC_SCO_INSERT
( V_REGI_NUM  IN TBL_CRSE_REGISTER.REGI_NUM%TYPE
, V_OPSUB_NUM IN TBL_OPEN_SUB.OPSUB_NUM%TYPE
, V_SCO_ATD NUMBER
, V_SCO_PRC NUMBER
, V_SCO_WRT NUMBER
)
IS
    V_ATD_RATE TBL_OPEN_SUB.ATD_RATE%TYPE;
    V_PRC_RATE TBL_OPEN_SUB.PRC_RATE%TYPE;
    V_WRT_RATE TBL_OPEN_SUB.WRT_RATE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    -- ���������� �������� ��������
    SELECT ATD_RATE INTO V_ATD_RATE
    FROM TBL_OPEN_SUB
    WHERE OPSUB_NUM = V_OPSUB_NUM;
    
    SELECT PRC_RATE INTO V_PRC_RATE
    FROM TBL_OPEN_SUB
    WHERE OPSUB_NUM = V_OPSUB_NUM;
    
    SELECT WRT_RATE INTO V_WRT_RATE
    FROM TBL_OPEN_SUB
    WHERE OPSUB_NUM = V_OPSUB_NUM;
    
    -- ���������϶��� ��� ����
    IF (V_SCO_ATD <= V_ATD_RATE AND V_SCO_PRC <= V_PRC_RATE AND V_SCO_WRT <= V_WRT_RATE)
        THEN
        INSERT INTO TBL_SCORE(SCO_NUM, REGI_NUM, OPSUB_NUM, SCO_ATD, SCO_PRC, SCO_WRT)
        VALUES(SEQ_SCORE.NEXTVAL, V_REGI_NUM, V_OPSUB_NUM, V_SCO_ATD, V_SCO_PRC, V_SCO_WRT);
    ELSE
        RAISE USER_DEFINE_ERROR;    
    END IF;
    
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007, '�Է������� ���������� ������ϴ�.'); 

        WHEN OTHERS
            THEN ROLLBACK;
    
END;




---------------------------------------------------------------------------------------------------------------

--��� ���� ��ȸ
/*
CREATE VIEW VIEW_PROFESSOR
AS
SELECT *
FROM TBL_PROFESSOR;
*/






























