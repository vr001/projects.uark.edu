create table USER
(
  user_key int primary key,
  email varchar(30) not  null,
  user_name varchar(30) not null,
  profile_picture varchar(200),
  private_profile tinyint not null,
  user_creation_time timestamp not null
);

create table LINK_GROUP_USER
(
  group_key int ,
  user_key int,
  group_user_creation_time timestamp not null,
  primary key (group_key,user_key)
);

create table GROUPS
(
  group_key int primary key,
  name varchar(50) not null,
  createdby_user_key int ,
  group_creation_time timestamp not null,
  foreign key (createdby_user_key)  references USER(user_key)
);

create table GROUP_ADMIN
(
  group_key int,
  user_key int,
  primary key (group_key,user_key)
);

create table content
(
  content_key int not null,
  parent_content_key int,
  thread_key int,
  project_key int,
  group_key int,
  createdby_user_key int not null,
  creation_time timestamp not null,
  editedby_user_key int not null,
  edited_time timestamp not null,
  deletedby_user_key int,
  deleted_time timestamp,
  primary key (content_key),
  foreign key (parent_content_key) references content(content_key),
  foreign key (thread_key) references content(content_key),
  foreign key (project_key) references content(content_key),
  foreign key (group_key) references groups(group_key),
  foreign key (createdby_user_key) references user(user_key),
  foreign key (editedby_user_key) references user(user_key),
  foreign key (deletedby_user_key) references user(user_key)
);
