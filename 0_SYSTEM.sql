
/*
������ �ּ�
*/
--���ѡ��١��ּ�


--�������ڡ����������������ͺ��̽��ǡ���������������������ϴ¡����ۡ�����������
--                 ������Ʈ�������������棬�����������ǡ��۾�������
--                �����ͺ��̽��������ѡ���硡���ѡ��ס�å����������
--������ڡ����������������ͺ��̽��������ѡ�����(QUERY)�������ţ������������ۼ�����۾����������ҡ������ִ¡�����
--                  �Ϲݡ��������������������ء����������ʿ��ѡ��ּ����ǡ����Ѹ��������¡���������Ģ���Ρ���

--�������硡����
--CREATE USER KH IDENTIFIED BY KH; --������������������
--����    ������         ����й�ȣ������
--               �����̸�                       ��й�ȣ���������ε��������̸���������������ϰԣ�

--��12c ������
--��18c������
-- CREATE USER c##KH IDENTIFIED BY KH;
-- c##�������̴¡����̡����ŷӱ⡡������������������ó�����ȡ����̰����������������ҡ������ִ¡����ǡ�����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER KH IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO KH; -- ���� �ο� ����

--��Data Dictionary(DD), �����͡�����
--�������ͺ��̽��ǡ������͸��������ѡ�DB�����ݿ������ѡ���硡����������
--��SYSTEM(������)�̡�DD�������ѡ��������������ҡ������ִ¡������������������ְ�
--������ڡ����������ܼ�����ȸ�������ɣ��б⡡���롡���·Ρ������ʣ�

-- ���̺� : ��(row)�� ��(column)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
--         �����ͺ��̽� ������ ��� �����ʹ� ���̺��� ���� ����
-- �ε��� : �˻� ������ ����ȭ�ϱ� ���� �����ͺ��̽� �� ����� ������ �����ϴ� ������ ����
--         �ε����� �̿��ϸ� ��ü �����͸� �˻����� �ʰ� �����ͺ��̽����� ���ϴ� ������ ������ �˻� ����
--         (������ �� ������ ���� �� �߿�, �����ؾ� ��)

alter user KH default tablespace system quota unlimited on system;
-- ���̺� �����̽� �뷮�� ������ ���� �ʰ� ����ڴ�
-- �̸�&��й�ȣ�� ���ͷ��� ��ҹ��ڸ� ������ �������� ��ҹ��� �������