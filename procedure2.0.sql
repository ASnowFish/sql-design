/*�������԰�*/
DROP PROCEDURE IF EXISTS messageboard_name;
DELIMITER //
CREATE PROCEDURE messageboard_name(m_num INT)
  BEGIN
    INSERT INTO messageboard (MessageBoardNumber) VALUES (m_num);
  END
//
DELIMITER ;
/*call messageboard_name(99);*/

/*ɾ�����԰�*/
DROP PROCEDURE IF EXISTS messageboard_delete;
DELIMITER //
CREATE PROCEDURE messageboard_delete(m_num INT)
  BEGIN
    DELETE FROM messageboard
    WHERE MessageBoardNumber = m_num;
  END
//
DELIMITER ;
/*call messageboard_delete(99);*/


/*�����û� ��ʼ��һ�����԰���û�*/
/*alter table user change UseName UserName varchar(10);
alter table user change UsePassword UserPassword varchar(32);
alter table user change WorksQuantity WorksQuantity int;
alter table user change RecipesQuantity RecipesQuantity int;*/
DROP PROCEDURE IF EXISTS user_information;
DELIMITER //
CREATE PROCEDURE user_information(
  u_num  INT,
  m_num  INT,
  u_name VARCHAR(10),
  pwd    VARCHAR(32),
  email  VARCHAR(32))
  BEGIN
    INSERT INTO messageboard (MessageBoardNumber) VALUES (m_num);
    INSERT INTO user (
      UserNumber,
      MessageBoardNumber,
      UseName,
      UsePassword,
      UsereMail,
      RegisterTime,
      WorksQuantity,
      RecipesQuantity)
    VALUES (u_num, m_num, u_name, pwd, email, curdate(), 0, 0);
  END//
DELIMITER ;
/*call user_infromation(10,'taobaiyang','123456','taobaiyang@qq.com');*/

/*(δʵ��)ɾ���û���һ�㲻Ҫ������������ ɾ�����Ӧ�����԰壬�û��Ĳ��ף��û�����Ʒ,�û���Ʒ��Ӧ�����԰�
*/



/*��Ӳ��� �������׵����԰�*/


DROP PROCEDURE IF EXISTS recipes_information;
DELIMITER //
CREATE PROCEDURE recipes_information(
  r_num  INT,
  u_num  INT,
  m_num  INT,
  r_name CHAR(30),
  r_des  VARCHAR(1024),
  note_t   VARCHAR(1024),
  cover_t  LONGBLOB)
  BEGIN
    INSERT INTO messageboard (MessageBoardNumber) VALUES (m_num);
    INSERT INTO recipes (
      RecipesNumber,
      UserNumber,
      MessageBoardNumber,
      RecipesName,
      ReleaseDate,
      RecipesDescription,
      Note,
      Cover)
    VALUES (r_num, u_num, m_num, r_name, sysdate(), r_des, note_t, cover_t);
  END//
DELIMITER ;
/*����*/
/*delete from recipes where RecipesNumber=20;
delete from messageboard where MessageBoardNumber=9; 
call recipes_information(20,10,9,'tao','sad','asf','12');
LOAD DATA LOCAL INFILE 'D:\\e\\1.txt' INTO TABLE recipes
FIELDS TERMINATED BY '/';*/


/*ɾ������  ɾ���������԰壬ɾ����Ӧ��Ʒ�����԰� ��ʵ��*/


/*�����Ʒ ������Ʒ���԰�*/

DROP PROCEDURE IF EXISTS works_information;
DELIMITER //
CREATE PROCEDURE works_information(
  w_num INT,
  m_num INT,
  u_num INT,
  r_num INT,
  w_img LONGBLOB,
  w_des VARCHAR(1024)
)
  BEGIN
    INSERT INTO messageboard (MessageBoardNumber) VALUES (m_num);
    INSERT INTO works (
      WorksNumber,
      MessageBoardNumber,
      UserNumber,
      RecipesNumber,
      WorksImage,
      ReleaseDate,
      WorksDescription)
    VALUES (w_num, m_num, u_num, r_num, w_img, sysdate(), w_des);
  END//
DELIMITER ;

/*ɾ����Ʒ ɾ�����԰� */
DROP PROCEDURE IF EXISTS works_delete;
DELIMITER //
CREATE PROCEDURE works_delete(w_num INT)
  BEGIN
    DELETE FROM works
    WHERE WorksNumber = w_num;
    DELETE FROM messageboard
    WHERE MessageBoardNumber = (
      SELECT MessageBoardNumber
      FROM works
      WHERE WorksNumber = w_num);
  END//
DELIMITER ;

/*��Ӳ��ײ���*/
DROP PROCEDURE IF EXISTS add_steps;
DELIMITER //
CREATE PROCEDURE add_steps(
  s_num  INT,
  r_num  INT,
  method_t VARCHAR(256),
  mImage LONGBLOB
)
  BEGIN
    INSERT INTO step (StepNumber, RecipesNumber, Method, MethodImage)
    VALUES (s_num, r_num, method_t, mImage);
  END//
DELIMITER ;

/*ɾ�����ײ���*/
DROP PROCEDURE IF EXISTS delete_steps;
DELIMITER //
CREATE PROCEDURE delete_steps(s_num INT)
  BEGIN
    DELETE FROM step
    WHERE StepNumber = s_num;
  END//
DELIMITER ;

/*������ϱ�*/
DROP PROCEDURE IF EXISTS ingredient_list;
DELIMITER //
CREATE PROCEDURE ingredient_list(
  i_num    INT,
  r_num    INT,
  i_name   VARCHAR(20),
  quantity VARCHAR(20))
  BEGIN
    INSERT INTO ingredientslist (
      IngredientsList,
      RecipesNumber,
      IngredientsName,
      IngredientsQuantity)
    VALUES (i_num, r_num, i_name, quantity);
  END//
DELIMITER ;

/*ɾ�����ϱ�*/
DROP PROCEDURE IF EXISTS ingredient_delete;
DELIMITER //
CREATE PROCEDURE ingredient_delete(i_num INT)

  BEGIN
    DELETE FROM ingredientslist
    WHERE IngredientsList = i_num;

  END//
DELIMITER ;

/*������ó���*/
DROP PROCEDURE IF EXISTS add_situation;
DELIMITER //
CREATE PROCEDURE add_situation(
  s_num  INT,
  s_name VARCHAR(20))
  BEGIN
    INSERT INTO situation (SituationNumber, SituationName) VALUES (s_num, s_name);
  END//
DELIMITER ;

/*������ó��ϺͲ�����ϵ*/
DROP PROCEDURE IF EXISTS situation_recipes;
DELIMITER //
CREATE PROCEDURE situation_recipes(
  s_num INT,
  r_num INT)
  BEGIN
    INSERT INTO situationtorecipes (SituationNumber, RecipesNumber) VALUES (s_num, r_num);
  END//
DELIMITER ;

/*�����ɫʳƷ*/
DROP PROCEDURE IF EXISTS add_specialcuisine;
DELIMITER //
CREATE PROCEDURE add_specialcuisine(
  s_num  INT,
  s_name VARCHAR(20))
  BEGIN
    INSERT INTO specialcuisine (SpecialCuisineNumber, SpecialCusineName) VALUES (s_num, s_name);
  END//
DELIMITER ;

/*�����ɫʳƷ�Ͳ�����ϵ*/
DROP PROCEDURE IF EXISTS specialcuisine_recipes;
DELIMITER //
CREATE PROCEDURE specialcuisine_recipes(
  s_num INT,
  r_num INT)
  BEGIN
    INSERT INTO specialcuisinetorecipes (SpecialCuisineNumber, RecipesNumber) VALUES (s_num, r_num);
  END//
DELIMITER ;

/*�������*/
DROP PROCEDURE IF EXISTS add_theme;
DELIMITER //
CREATE PROCEDURE add_theme(
  t_num  INT,
  t_name VARCHAR(20))
  BEGIN
    INSERT INTO theme (ThemeNumber, ThemeName) VALUES (t_num, t_name);
  END//
DELIMITER ;

/*�������Ͳ�����ϵ*/
DROP PROCEDURE IF EXISTS theme_recipes;
DELIMITER //
CREATE PROCEDURE theme_recipes(
  t_num INT,
  r_num INT)
  BEGIN
    INSERT INTO themetorecipes (ThemeNumber, RecipesNumber) VALUES (t_num, r_num);
  END//
DELIMITER ;

/*�����Ⱥ*/
DROP PROCEDURE IF EXISTS add_people;
DELIMITER //
CREATE PROCEDURE add_people(
  p_num  INT,
  p_name VARCHAR(20))
  BEGIN
    INSERT INTO people (PeopleNumber, PeopleType) VALUES (p_num, p_name);
  END//
DELIMITER ;

/*�����Ⱥ�Ͳ�����ϵ*/

DROP PROCEDURE IF EXISTS People_recipes;
DELIMITER //
CREATE PROCEDURE people_recipes(
  p_num INT,
  r_num INT)
  BEGIN
    INSERT INTO peopletorecipes (PeopleNumber, RecipesNumber) VALUES (p_num, r_num);
  END//
DELIMITER ;

/*���ʳ�ķ���*/
DROP PROCEDURE IF EXISTS add_material;
DELIMITER //
CREATE PROCEDURE add_material(
  m_num  INT,
  m_name VARCHAR(20))
  BEGIN
    INSERT INTO material (materialNumber, materialName) VALUES (m_num, m_name);
  END//
DELIMITER ;

/*���ʳ�ķ���Ͳ�����ϵ*/
DROP PROCEDURE IF EXISTS material_recipes;
DELIMITER //
CREATE PROCEDURE material_recipes(
  m_num INT,
  r_num INT)
  BEGIN
    INSERT INTO recipestometerial (materialNumber, RecipesNumber) VALUES (m_num, r_num);
  END//
DELIMITER ;

