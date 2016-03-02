-- drop tables
DROP TABLE IF EXISTS Votes;
DROP TABLE IF EXISTS Link_Groups_Content;
DROP TABLE IF EXISTS Link_Groups_Users;
DROP TABLE IF EXISTS Content;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS Users;

-- tables
CREATE TABLE IF NOT EXISTS Users (
  user_key INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(30) NOT NULL,
  user_name VARCHAR(30) NOT NULL,
  profile_picture VARCHAR(200),
  private_profile BOOLEAN DEFAULT FALSE,
  user_creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Groups (
  group_key INT PRIMARY KEY AUTO_INCREMENT,
  group_name VARCHAR(50) NOT NULL,
  group_createdby_user_key INT NOT NULL,
  FOREIGN KEY (group_createdby_user_key) REFERENCES Users(user_key),
  group_creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Content (
  content_title VARCHAR(100), -- nullable for comments
  content_value VARCHAR(1000), -- nullable for threads
  content_key INT PRIMARY KEY AUTO_INCREMENT,
  project_key INT NOT NULL,
  FOREIGN KEY (project_key) REFERENCES Content(content_key),
  thread_key INT,
  FOREIGN KEY (thread_key) REFERENCES Content(content_key),
  parent_content_key INT,
  FOREIGN KEY (parent_content_key) REFERENCES Content(content_key),
  has_children BOOLEAN DEFAULT FALSE,
  content_createdby_user_key INT NOT NULL,
  FOREIGN KEY (content_createdby_user_key) REFERENCES Users(user_key),
  content_creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  content_editedby_user_key INT,
  FOREIGN KEY (content_editedby_user_key) REFERENCES Users(user_key),
  content_edited_time TIMESTAMP NULL,
  content_deletedby_user_key INT,
  FOREIGN KEY (content_deletedby_user_key) REFERENCES Users(user_key),
  content_deleted_time TIMESTAMP NULL
);

-- link tables
CREATE TABLE IF NOT EXISTS Link_Groups_Users (
  group_key INT NOT NULL,
  FOREIGN KEY (group_key) REFERENCES Groups(group_key),
  user_key INT NOT NULL,
  FOREIGN KEY (user_key) REFERENCES Users(user_key),
  is_admin BOOLEAN DEFAULT FALSE,
  group_user_creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (group_key,user_key)
);

CREATE TABLE IF NOT EXISTS Link_Groups_Content (
  group_key INT NOT NULL,
  FOREIGN KEY (group_key) REFERENCES Groups(group_key),
  content_key INT NOT NULL,
  FOREIGN KEY (content_key) REFERENCES Content(content_key),
  PRIMARY KEY (group_key,content_key)
);

-- votes
CREATE TABLE IF NOT EXISTS Votes (
  content_key INT NOT NULL,
  FOREIGN KEY (content_key) REFERENCES Content(content_key),
  user_key INT NOT NULL,
  FOREIGN KEY (user_key) REFERENCES Users(user_key),
  vote_value BOOLEAN NOT NULL,
  vote_creation_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_key,content_key)
);
