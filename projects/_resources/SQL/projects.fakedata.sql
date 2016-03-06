-- create project
INSERT INTO Content (content_title, content_value, content_createdby_user_key)
  VALUES ('Project Hello World!', 'This is the first project.', 1);
-- create thread
INSERT INTO Content (content_title, project_key, parent_content_key, content_createdby_user_key)
  VALUES
('first thread on project', 1, 1, 1),
('second thread on project', 1, 1, 2);
-- create comment
INSERT INTO Content (content_value, project_key, thread_key, parent_content_key, content_createdby_user_key)
  VALUES
('this is the 1st message in the 1st thread of the 1st project.', 1, 2, 2, 1),
('this is the 2nd message in the 1st thread of the 1st project.', 1, 2, 2, 2),
('this is the 1st reply to the 1st message in the 1st thread of the 1st project.', 1, 2, 4, 2);
