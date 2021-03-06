create table book (id INTEGER PRIMARY KEY auto_increment, title VARCHAR(31), authors VARCHAR(31), published_Date VARCHAR(31), description VARCHAR(400), owner VARCHAR(31), location VARCHAR(31), thumbnail VARCHAR(31), smallThumbnail VARCHAR(31));

create table checkout (id INTEGER PRIMARY KEY auto_increment, book_id INTEGER , date_time_from TIMESTAMP WITH TIME ZONE , date_time_to TIMESTAMP WITH TIME ZONE , user_email VARCHAR(31));

create table comment (id INTEGER PRIMARY KEY auto_increment, book_id INTEGER , date_time TIMESTAMP WITH TIME ZONE , user_email VARCHAR(31), rating INTEGER, remarks VARCHAR(400));
