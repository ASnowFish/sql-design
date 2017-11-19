create table auth_group
(
	id int auto_increment
		primary key,
	name varchar(80) not null,
	constraint name
		unique (name)
)
;

create table auth_group_permissions
(
	id int auto_increment
		primary key,
	group_id int not null,
	permission_id int not null,
	constraint auth_group_permissions_group_id_0cd325b0_uniq
		unique (group_id, permission_id),
	constraint auth_group_permissions_group_id_b120cbf9_fk_auth_group_id
		foreign key (group_id) references meishijia.auth_group (id)
)
;

create index auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id
	on auth_group_permissions (permission_id)
;

create table auth_permission
(
	id int auto_increment
		primary key,
	name varchar(255) not null,
	content_type_id int not null,
	codename varchar(100) not null,
	constraint auth_permission_content_type_id_01ab375a_uniq
		unique (content_type_id, codename)
)
;

alter table auth_group_permissions
	add constraint auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id
		foreign key (permission_id) references meishijia.auth_permission (id)
;

create table auth_user
(
	id int auto_increment
		primary key,
	password varchar(128) not null,
	last_login datetime null,
	is_superuser tinyint(1) not null,
	username varchar(150) not null,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	email varchar(254) not null,
	is_staff tinyint(1) not null,
	is_active tinyint(1) not null,
	date_joined datetime not null,
	constraint username
		unique (username)
)
;

create table auth_user_groups
(
	id int auto_increment
		primary key,
	user_id int not null,
	group_id int not null,
	constraint auth_user_groups_user_id_94350c0c_uniq
		unique (user_id, group_id),
	constraint auth_user_groups_user_id_6a12ed8b_fk_auth_user_id
		foreign key (user_id) references meishijia.auth_user (id),
	constraint auth_user_groups_group_id_97559544_fk_auth_group_id
		foreign key (group_id) references meishijia.auth_group (id)
)
;

create index auth_user_groups_group_id_97559544_fk_auth_group_id
	on auth_user_groups (group_id)
;

create table auth_user_user_permissions
(
	id int auto_increment
		primary key,
	user_id int not null,
	permission_id int not null,
	constraint auth_user_user_permissions_user_id_14a6b632_uniq
		unique (user_id, permission_id),
	constraint auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id
		foreign key (user_id) references meishijia.auth_user (id),
	constraint auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id
		foreign key (permission_id) references meishijia.auth_permission (id)
)
;

create index auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id
	on auth_user_user_permissions (permission_id)
;

create table comment
(
	CommentNumber int auto_increment
		primary key,
	MessageBoardNumber int not null,
	CommentContent text not null
)
comment '评论'
;

create index FK_MessageBoardToComment
	on comment (MessageBoardNumber)
;

create table django_admin_log
(
	id int auto_increment
		primary key,
	action_time datetime not null,
	object_id longtext null,
	object_repr varchar(200) not null,
	action_flag smallint not null,
	change_message longtext not null,
	content_type_id int null,
	user_id int not null,
	constraint django_admin_log_user_id_c564eba6_fk_auth_user_id
		foreign key (user_id) references meishijia.auth_user (id)
)
;

create index django_admin_log_user_id_c564eba6_fk_auth_user_id
	on django_admin_log (user_id)
;

create index django_admin__content_type_id_c4bce8eb_fk_django_content_type_id
	on django_admin_log (content_type_id)
;

create table django_content_type
(
	id int auto_increment
		primary key,
	app_label varchar(100) not null,
	model varchar(100) not null,
	constraint django_content_type_app_label_76bd3d3b_uniq
		unique (app_label, model)
)
;

alter table auth_permission
	add constraint auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id
		foreign key (content_type_id) references meishijia.django_content_type (id)
;

alter table django_admin_log
	add constraint django_admin__content_type_id_c4bce8eb_fk_django_content_type_id
		foreign key (content_type_id) references meishijia.django_content_type (id)
;

create table django_migrations
(
	id int auto_increment
		primary key,
	app varchar(255) not null,
	name varchar(255) not null,
	applied datetime not null
)
;

create table django_session
(
	session_key varchar(40) not null
		primary key,
	session_data longtext not null,
	expire_date datetime not null
)
;

create index django_session_de54fa62
	on django_session (expire_date)
;

create table ingredientslist
(
	IngredientsList int auto_increment
		primary key,
	RecipesNumber int not null,
	IngredientsName varchar(20) not null,
	IngredientsQuantity varchar(20) null
)
comment '菜谱所用用料'
;

create index FK_IngredientsListToRecipes
	on ingredientslist (RecipesNumber)
;

create table material
(
	MaterialNumber int not null
		primary key,
	MaterialName varchar(20) not null,
	isCommonMaterial tinyint(1) default '1' not null,
	isSeasonMaterial tinyint(1) default '0' not null
)
comment '食材'
;

create table messageboard
(
	MessageBoardNumber int not null
		primary key
)
comment '留言板'
;

alter table comment
	add constraint FK_MessageBoardToComment
		foreign key (MessageBoardNumber) references meishijia.messageboard (MessageBoardNumber)
;

create table people
(
	PeopleNumber int not null
		primary key,
	PeopleType varchar(10) not null
)
comment '对象人群'
;

create table peopletorecipes
(
	PeopleNumber int not null,
	RecipesNumber int not null,
	primary key (PeopleNumber, RecipesNumber),
	constraint FK_PeopleToRecipes
		foreign key (PeopleNumber) references meishijia.people (PeopleNumber)
)
comment '其主键作为菜谱外键'
;

create index FK_PeopleToRecipes2
	on peopletorecipes (RecipesNumber)
;

create table recipes
(
	RecipesNumber int not null
		primary key,
	UserNumber int not null,
	MessageBoardNumber int not null,
	RecipesName char(30) not null,
	ReleaseDate datetime not null,
	RecipesDescription varchar(1024) not null,
	Note varchar(1024) null,
	Cover longblob not null,
	constraint FK_RecipesToMessageBoard
		foreign key (MessageBoardNumber) references meishijia.messageboard (MessageBoardNumber)
)
comment '菜谱'
;

create index FK_RecipesToMessageBoard
	on recipes (MessageBoardNumber)
;

create index FK_UserToRecipes
	on recipes (UserNumber)
;

create trigger RecipesCount
             before INSERT on recipes
             for each row
BEGIN
    UPDATE user
    SET RecipesQuantity = RecipesQuantity + 1
    WHERE UserNumber = NEW.UserNumber;
  END;

alter table ingredientslist
	add constraint FK_IngredientsListToRecipes
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
;

alter table peopletorecipes
	add constraint FK_PeopleToRecipes2
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
;

create table recipestometerial
(
	MaterialNumber int not null,
	RecipesNumber int not null,
	primary key (MaterialNumber, RecipesNumber),
	constraint FK_RecipesToMeterial
		foreign key (MaterialNumber) references meishijia.material (MaterialNumber),
	constraint FK_RecipesToMeterial2
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
)
comment '其主键作为菜谱外键，菜谱的主要食材类别'
;

create index FK_RecipesToMeterial2
	on recipestometerial (RecipesNumber)
;

create table situation
(
	SituationNumber int not null
		primary key,
	SituationName varchar(20) not null
)
comment '适用场合'
;

create table situationtorecipes
(
	SituationNumber int not null,
	RecipesNumber int not null,
	primary key (SituationNumber, RecipesNumber),
	constraint FK_SituationToRecipes
		foreign key (SituationNumber) references meishijia.situation (SituationNumber),
	constraint FK_SituationToRecipes2
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
)
;

create index FK_SituationToRecipes2
	on situationtorecipes (RecipesNumber)
;

create table specialcuisine
(
	SpecialCuisineNumber int not null
		primary key,
	SpecialCusineName varchar(30) not null
)
comment '特色食品'
;

create table specialcuisinetorecipes
(
	RecipesNumber int not null,
	SpecialCuisineNumber int not null,
	primary key (RecipesNumber, SpecialCuisineNumber),
	constraint FK_SpecialCuisineToRecipes
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber),
	constraint FK_SpecialCuisineToRecipes2
		foreign key (SpecialCuisineNumber) references meishijia.specialcuisine (SpecialCuisineNumber)
)
comment '其主键作为菜谱外键'
;

create index FK_SpecialCuisineToRecipes2
	on specialcuisinetorecipes (SpecialCuisineNumber)
;

create table step
(
	StepNumber int auto_increment
		primary key,
	RecipesNumber int not null,
	Method varchar(256) not null,
	MethodImage longblob null,
	constraint FK_StepToRecipes
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
)
comment '具体食谱的步骤'
;

create index FK_StepToRecipes
	on step (RecipesNumber)
;

create table theme
(
	ThemeNumber int not null
		primary key,
	ThemeName varchar(10) not null
)
comment '对食谱按照主题分类'
;

create table themetorecipes
(
	RecipesNumber int not null,
	ThemeNumber int not null,
	primary key (RecipesNumber, ThemeNumber),
	constraint FK_ThemeToRecipes
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber),
	constraint FK_ThemeToRecipes2
		foreign key (ThemeNumber) references meishijia.theme (ThemeNumber)
)
comment '每个菜谱可以选择所属主题，其主键作为菜谱外键'
;

create index FK_ThemeToRecipes2
	on themetorecipes (ThemeNumber)
;

create table user
(
	UserNumber int not null
		primary key,
	MessageBoardNumber int not null,
	UserName varchar(10) not null,
	UserPassword varchar(32) not null,
	UsereMail varchar(32) not null,
	RegisterTime date not null,
	WorksQuantity int default '0' not null,
	RecipesQuantity int default '0' not null,
	constraint FK_UserToMessageBoard
		foreign key (MessageBoardNumber) references meishijia.messageboard (MessageBoardNumber)
)
comment '用户'
;

create index FK_UserToMessageBoard
	on user (MessageBoardNumber)
;

alter table recipes
	add constraint FK_UserToRecipes
		foreign key (UserNumber) references meishijia.user (UserNumber)
;

create table works
(
	WorksNumber int auto_increment
		primary key,
	MessageBoardNumber int not null,
	UserNumber int not null,
	RecipesNumber int null,
	WorksImage longblob not null,
	ReleaseDate datetime not null,
	WorksDescription varchar(1024) null,
	constraint FK_WorksToMessageBoard
		foreign key (MessageBoardNumber) references meishijia.messageboard (MessageBoardNumber),
	constraint FK_UserToWorks
		foreign key (UserNumber) references meishijia.user (UserNumber),
	constraint FK_RecipesToWorks
		foreign key (RecipesNumber) references meishijia.recipes (RecipesNumber)
)
comment '用户根据食谱或者自己制作的作品'
;

create index FK_RecipesToWorks
	on works (RecipesNumber)
;

create index FK_UserToWorks
	on works (UserNumber)
;

create index FK_WorksToMessageBoard
	on works (MessageBoardNumber)
;

create trigger WorksCount
             before INSERT on works
             for each row
BEGIN
    UPDATE user
    SET WorksQuantity = WorksQuantity + 1
    WHERE UserNumber = NEW.UserNumber;
  END;

create procedure add_material (IN m_num int, IN m_name varchar(20))  
BEGIN
    INSERT INTO material (materialNumber, materialName) VALUES (m_num, m_name);
  END;

create procedure add_people (IN p_num int, IN p_name varchar(20))  
BEGIN
    INSERT INTO people (PeopleNumber, PeopleType) VALUES (p_num, p_name);
  END;

create procedure add_situation (IN s_num int, IN s_name varchar(20))  
BEGIN
    INSERT INTO situation (SituationNumber, SituationName) VALUES (s_num, s_name);
  END;

create procedure add_specialcuisine (IN s_num int, IN s_name varchar(20))  
BEGIN
    INSERT INTO specialcuisine (SpecialCuisineNumber, SpecialCusineName) VALUES (s_num, s_name);
  END;

create procedure add_steps (IN s_num int, IN r_num int, IN method_t varchar(256), IN mImage longblob)  
BEGIN
    INSERT INTO step (StepNumber, RecipesNumber, Method, MethodImage)
    VALUES (s_num, r_num, method_t, mImage);
  END;

create procedure add_theme (IN t_num int, IN t_name varchar(20))  
BEGIN
    INSERT INTO theme (ThemeNumber, ThemeName) VALUES (t_num, t_name);
  END;

create procedure delete_steps (IN s_num int)  
BEGIN
    DELETE FROM step
    WHERE StepNumber = s_num;
  END;

create procedure ingredient_delete (IN i_num int)  
BEGIN
    DELETE FROM ingredientslist
    WHERE IngredientsList = i_num;

  END;

create procedure ingredient_list (IN i_num int, IN r_num int, IN i_name varchar(20), IN quantity varchar(20))  
BEGIN
    INSERT INTO ingredientslist (
      IngredientsList,
      RecipesNumber,
      IngredientsName,
      IngredientsQuantity)
    VALUES (i_num, r_num, i_name, quantity);
  END;

create procedure material_recipes (IN m_num int, IN r_num int)  
BEGIN
    INSERT INTO recipestometerial (materialNumber, RecipesNumber) VALUES (m_num, r_num);
  END;

create procedure messageboard_delete (IN m_num int)  
BEGIN
    DELETE FROM messageboard
    WHERE MessageBoardNumber = m_num;
  END;

create procedure messageboard_name (IN m_num int)  
BEGIN
    INSERT INTO messageboard (MessageBoardNumber) VALUES (m_num);
  END;

create procedure people_recipes (IN p_num int, IN r_num int)  
BEGIN
    INSERT INTO peopletorecipes (PeopleNumber, RecipesNumber) VALUES (p_num, r_num);
  END;

create procedure recipes_information (IN r_num int, IN u_num int, IN m_num int, IN r_name char(30), IN r_des varchar(1024), IN note_t varchar(1024), IN cover_t longblob)  
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
  END;

create procedure situation_recipes (IN s_num int, IN r_num int)  
BEGIN
    INSERT INTO situationtorecipes (SituationNumber, RecipesNumber) VALUES (s_num, r_num);
  END;

create procedure specialcuisine_recipes (IN s_num int, IN r_num int)  
BEGIN
    INSERT INTO specialcuisinetorecipes (SpecialCuisineNumber, RecipesNumber) VALUES (s_num, r_num);
  END;

create procedure theme_recipes (IN t_num int, IN r_num int)  
BEGIN
    INSERT INTO themetorecipes (ThemeNumber, RecipesNumber) VALUES (t_num, r_num);
  END;

create procedure user_information (IN u_num int, IN m_num int, IN u_name varchar(10), IN pwd varchar(32), IN email varchar(32))  
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
  END;

create procedure works_delete (IN w_num int)  
BEGIN
    DELETE FROM works
    WHERE WorksNumber = w_num;
    DELETE FROM messageboard
    WHERE MessageBoardNumber = (
      SELECT MessageBoardNumber
      FROM works
      WHERE WorksNumber = w_num);
  END;

create procedure works_information (IN w_num int, IN m_num int, IN u_num int, IN r_num int, IN w_img longblob, IN w_des varchar(1024))  
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
  END;

