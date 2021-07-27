drop table AbstractNode cascade constraints;
drop table BaseAction cascade constraints;
drop table Chat cascade constraints;
drop table ChatEntry cascade constraints;
drop table ErrorLog cascade constraints;
drop table Role cascade constraints;
drop table Server cascade constraints;
drop table TPF_USER cascade constraints;
drop table USER_ROLE cascade constraints;
drop sequence hibernate_sequence;
create table AbstractNode (DTYPE varchar2(31 char) not null, id number(19,0) not null, answer varchar2(255 char), description varchar2(255 char), keywords varchar2(255 char), action_id number(19,0), errorTransition_id number(19,0), parent_id number(19,0), primary key (id), unique (description));
create table BaseAction (DTYPE varchar2(31 char) not null, id number(19,0) not null, version number(19,0), description varchar2(255 char), methodNane varchar2(255 char), serviceName varchar2(255 char), wsdlUrl varchar2(255 char), primary key (id), unique (description));
create table Chat (id number(19,0) not null, version number(19,0), chat_client varchar2(255 char), finalNode varchar2(255 char), chat_length number(10,0), is_successful number(1,0), server_id number(19,0), primary key (id));
create table ChatEntry (id number(19,0) not null, version number(19,0), cdate timestamp, message varchar2(255 char), userQuery number(1,0) not null, chat_id number(19,0), primary key (id));
create table ErrorLog (id number(19,0) not null, version number(19,0), message varchar2(500 char), stackTrace varchar2(1000 char), timestamp timestamp, primary key (id));
create table Role (id number(19,0) not null, version number(19,0), roleDescription varchar2(255 char), roleName varchar2(255 char), primary key (id));
create table Server (id number(19,0) not null, version number(19,0), enabled number(1,0) not null, hostname varchar2(255 char), maxChatterbots number(10,0) not null, maxLoad float not null, name varchar2(255 char), port number(10,0) not null, primary key (id), unique (hostname, port));
create table TPF_USER (id number(19,0) not null, version number(19,0), email varchar2(255 char), firstName varchar2(255 char), lastName varchar2(255 char), password varchar2(255 char), username varchar2(255 char), primary key (id));
create table USER_ROLE (USER_ID number(19,0) not null, ROLE_ID number(19,0) not null);
alter table AbstractNode add constraint FKDCA185641A30934D foreign key (action_id) references BaseAction;
alter table AbstractNode add constraint FKDCA18564DAB1BD9F foreign key (errorTransition_id) references AbstractNode;
alter table AbstractNode add constraint FKDCA185642ECE35D1 foreign key (parent_id) references AbstractNode;
alter table Chat add constraint FK200778BC72EAFC foreign key (server_id) references Server;
alter table ChatEntry add constraint FKD691FBDA6360975C foreign key (chat_id) references Chat;
alter table USER_ROLE add constraint FKBC16F46A896B1A9C foreign key (ROLE_ID) references Role;
alter table USER_ROLE add constraint FKBC16F46A2E95DE7C foreign key (USER_ID) references TPF_USER;
create sequence hibernate_sequence;