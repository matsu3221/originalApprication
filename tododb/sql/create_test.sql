create table test (
    id int not null,
    name1 VARCHAR(100) not null,
    createdate DATETIME,
    primary key(id)
);

insert into test value(
    1,'松本太郎',CURRENT_TIMESTAMP
);