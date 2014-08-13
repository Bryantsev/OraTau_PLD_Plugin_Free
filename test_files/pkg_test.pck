CREATE OR REPLACE PACKAGE pkg_test IS

-- Author  : ADMIN
-- Created : 30.11.2009 21:59:57
-- Purpose : -- привет

  PROCEDURE test;

END pkg_test;
/
CREATE OR REPLACE PACKAGE BODY pkg_test IS

  PROCEDURE test IS
  BEGIN
    -- привет
    -- c.my_const := 2;
    
    -- EXECUTE IMMEDIATE 'select 1 as tt from dual';
    -- 你好，世界
  END;
END pkg_test;
/
