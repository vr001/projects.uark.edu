CREATE TABLE Users
(
  user_key INT PRIMARY KEY,
  email VARCHAR(30) NOT NULL,
  user_name VARCHAR(30) NOT NULL,
  profile_picture VARCHAR(200),
  private_profile TINYINT NOT NULL,
  user_creation_time TIMESTAMP NOT NULL
);

CREATE TABLE Groups
(
  group_key INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  createdby_user_key INT ,
  group_creation_time TIMESTAMP NOT NULL,
  FOREIGN KEY (createdby_user_key)  REFERENCES Users(user_key)
);

CREATE TABLE Link_Groups_Users
(
  group_key INT NOT NULL,
  user_key INT NOT NULL,
  is_admin BOOLEAN,
  group_user_creation_time TIMESTAMP NOT NULL,
  FOREIGN KEY (user_key) REFERENCES Users(user_key),
  FOREIGN KEY (group_key) REFERENCES Groups(group_key),
  PRIMARY KEY (group_key,user_key)
);

CREATE TABLE Content
(
  title VARCHAR(100),
  content VARCHAR(1000),
  content_key INT NOT NULL,
  parent_content_key INT,
  has_children BOOLEAN,
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
  FOREIGN KEY (parent_content_key) REFERENCES Content(content_key),
  FOREIGN KEY (thread_key) REFERENCES Content(content_key),
  FOREIGN KEY (project_key) REFERENCES Content(content_key),
  FOREIGN KEY (group_key) REFERENCES Groups(group_key),
  FOREIGN KEY (createdby_user_key) REFERENCES Users(user_key),
  FOREIGN KEY (editedby_user_key) REFERENCES Users(user_key),
  FOREIGN KEY (deletedby_user_key) REFERENCES Users(user_key)
);

CREATE TABLE Vote
(
  content_key INT NOT NULL,
  user_key INT NOT NULL,
  vote BOOLEAN NOT NULL
);