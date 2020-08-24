create table knowledge (
 id INTEGER NOT NULL,
 knowledgeSubject VARCHAR(100) NOT NULL,
 createDate DATETIME,
 whatKnowledge VARCHAR(255),
 howKnowledge VARCHAR(255),
 referenceUrl VARCHAR(100),
 recordCreateDate DATETIME,
 recordUpdateDate DATETIME,
 PRIMARY KEY(id)
);