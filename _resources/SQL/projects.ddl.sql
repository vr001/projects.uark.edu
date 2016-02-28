CREATE TABLE USER
(
  user_key INT PRIMARY KEY,
  email VARCHAR(30) NOT NULL,
  user_name VARCHAR(30) NOT NULL,
  profile_picture VARCHAR(200),
  private_profile TINYINT NOT NULL,
  user_creation_time TIMESTAMP NOT NULL
);

CREATE TABLE LINK_GROUP_USER
(
  group_key INT ,
  user_key INT,
  group_user_creation_time TIMESTAMP NOT NULL,
  PRIMARY KEY (group_key,user_key)
);

CREATE TABLE GROUPS
(
  group_key INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  createdby_user_key INT ,
  group_creation_time TIMESTAMP NOT NULL,
  FOREIGN KEY (createdby_user_key)  REFERENCES USER(user_key)
);

CREATE TABLE GROUP_ADMIN
(
  group_key INT,
  user_key INT,
  PRIMARY KEY (group_key,user_key)
);

CREATE TABLE content
(
  content_key INT NOT NULL,
  parent_content_key INT,
  thread_key INT,
  project_key INT,
  group_key INT,
  createdby_user_key INT NOT NULL,
  creation_time TIMESTAMP NOT NULL,
  editedby_user_key INT NOT NULL,
  edited_time TIMESTAMP NOT NULL,
  deletedby_user_key INT,
  deleted_time TIMESTAMP,
  PRIMARY KEY (content_key),
  FOREIGN KEY (parent_content_key) REFERENCES content(content_key),
  FOREIGN KEY (thread_key) REFERENCES content(content_key),
  FOREIGN KEY (project_key) REFERENCES content(content_key),
  FOREIGN KEY (group_key) REFERENCES groups(group_key),
  FOREIGN KEY (createdby_user_key) REFERENCES user(user_key),
  FOREIGN KEY (editedby_user_key) REFERENCES user(user_key),
  FOREIGN KEY (deletedby_user_key) REFERENCES user(user_key)
);
