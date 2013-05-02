DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  id           INTEGER      NOT NULL PRIMARY KEY,
  name         VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS friends;
CREATE TABLE friends (
  id           INTEGER      NOT NULL PRIMARY KEY,
  name         VARCHAR(255) NOT NULL,
  customers_id VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS gifts;
CREATE TABLE gifts (
  id           INTEGER      NOT NULL PRIMARY KEY,
  description  VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS retailers;
CREATE TABLE retailers (
  id           INTEGER      NOT NULL PRIMARY KEY,
  name         VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS prices;
CREATE TABLE prices (
  price        FLOAT        NOT NULL PRIMARY KEY,
  retailers_id INTEGER      NOT NULL,
  gifts_id     INTEGER      NOT NULL
);

DROP TABLE IF EXISTS friends_has_gifts;
CREATE TABLE friends_has_gifts (
  friends_id   INTEGER      NOT NULL,
  gifts_id     INTEGER      NOT NULL
);
