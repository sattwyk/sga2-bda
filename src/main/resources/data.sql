
INSERT INTO author (id, name, email, country) VALUES
(1, 'J.K. Rowling', 'jk.rowling@hogwarts.com', 'United Kingdom'),
(2, 'George R.R. Martin', 'grrm@westeros.com', 'United States'),
(3, 'Haruki Murakami', 'murakami@tokyo.jp', 'Japan'),
(4, 'Chimamanda Ngozi Adichie', 'chimamanda@lagos.ng', 'Nigeria'),
(5, 'Gabriel Garcia Marquez', 'gabo@macondo.co', 'Colombia'),
(6, 'Margaret Atwood', 'atwood@canada.ca', 'Canada'),
(7, 'Isabel Allende', 'isabel@chile.cl', 'Chile'),
(8, 'Stephen King', 'sking@maine.us', 'United States'),
(9, 'Elena Ferrante', 'ferrante@napoli.it', 'Italy'),
(10, 'Khaled Hosseini', 'khaled@afghanistan.af', 'Afghanistan');


INSERT INTO book (id, title, isbn, price, author_id) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', '978-0747532699', 120.0, 1),
(2, 'A Game of Thrones', '978-0553103540', 150.0, 2),
(3, 'Norwegian Wood', '978-0375704024', 110.0, 3),
(4, 'Half of a Yellow Sun', '978-0007200283', 130.0, 4),
(5, 'One Hundred Years of Solitude', '978-0060883287', 140.0, 5),
(6, 'The Handmaid''s Tale', '978-0385490818', 125.0, 6),
(7, 'The House of the Spirits', '978-1501117015', 115.0, 7),
(8, 'The Shining', '978-0307743657', 135.0, 8),
(9, 'My Brilliant Friend', '978-1609450786', 128.0, 9),
(10, 'The Kite Runner', '978-1594631931', 145.0, 10);

-- Bump identity sequences so new inserts don't collide with seeded IDs
ALTER TABLE author ALTER COLUMN id RESTART WITH 11;
ALTER TABLE book ALTER COLUMN id RESTART WITH 11;
