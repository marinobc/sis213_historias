-- Datos de prueba para la tabla "Cards"
INSERT INTO Cards (cardCode, rarity, name, imgLink, marketPrice)
VALUES
    ('Card001', 'Rare', 'Card A', 'img001.jpg', 10.00),
    ('Card002', 'Common', 'Card B', 'img002.jpg', 5.00),
    ('Card003', 'Rare', 'Card C', 'img003.jpg', 15.00);

-- Datos de prueba para la tabla "City"
INSERT INTO City (name)
VALUES
    ('City A'),
    ('City B'),
    ('City C');

-- Datos de prueba para la tabla "Users"
INSERT INTO Users (name)
VALUES
    ('User 1'),
    ('User 2'),
    ('User 3');

-- Datos de prueba para la tabla "Auctions"
INSERT INTO Auctions (startDate, endDate, Price, isSell, isCancelled, Cards_cardCode, Users_idUser, City_idCity)
VALUES
    ('2023-11-09 19:00:00', '2023-11-09 20:00:00', 20.00, true, false, 'Card001', 1, 1),
    ('2023-11-10 14:00:00', '2023-11-10 16:00:00', 15.00, true, false, 'Card002', 2, 2),
    ('2023-11-11 10:00:00', '2023-11-11 12:00:00', 25.00, true, false, 'Card003', 3, 3);

-- Datos de prueba para la tabla "Images"
INSERT INTO Images (imgUpload, Auctions_idAuction)
VALUES
    ('img001.jpg', 1),
    ('img002.jpg', 2),
    ('img003.jpg', 3);

-- Datos de prueba para la tabla "Owners"
INSERT INTO Owners (Users_idUser, Cards_cardCode, acquired)
VALUES
    (1, 'Card001', '2023-11-09 19:30:00'),
    (2, 'Card002', '2023-11-10 14:30:00'),
    (3, 'Card003', '2023-11-11 10:30:00');

-- Datos de prueba para la tabla "Bids" (20 registros relacionados con la subasta 1)
INSERT INTO Bids (ammount, date, isWinner, Auctions_idAuction, Users_idUser)
VALUES
    (12.00, '2023-11-09 19:10:00', false, 1, 2),
    (18.00, '2023-11-09 19:15:00', false, 1, 3),
    (22.00, '2023-11-09 19:20:00', true, 1, 1),
    (25.00, '2023-11-09 19:25:00', true, 1, 3),
    (30.00, '2023-11-09 19:30:00', true, 1, 2),
    (35.00, '2023-11-09 19:35:00', true, 1, 1),
    (40.00, '2023-11-09 19:40:00', true, 1, 3),
    (45.00, '2023-11-09 19:45:00', true, 1, 2),
    (50.00, '2023-11-09 19:50:00', true, 1, 1),
    (55.00, '2023-11-09 19:55:00', true, 1, 3),
    (60.00, '2023-11-09 20:00:00', true, 1, 2),
    (65.00, '2023-11-09 20:05:00', true, 1, 1),
    (70.00, '2023-11-09 20:10:00', true, 1, 3),
    (75.00, '2023-11-09 20:15:00', true, 1, 2),
    (80.00, '2023-11-09 20:20:00', true, 1, 1),
    (85.00, '2023-11-09 20:25:00', true, 1, 3),
    (90.00, '2023-11-09 20:30:00', true, 1, 2),
    (95.00, '2023-11-09 20:35:00', true, 1, 1),
    (100.00, '2023-11-09 20:40:00', true, 1, 3),
    (105.00, '2023-11-09 20:45:00', true, 1, 2);

-- Datos de prueba para la subasta 2 en la tabla "Bids"
INSERT INTO Bids (ammount, date, isWinner, Auctions_idAuction, Users_idUser)
VALUES
    (10.00, '2023-11-10 14:05:00', false, 2, 1),
    (12.00, '2023-11-10 14:10:00', false, 2, 3),
    (14.00, '2023-11-10 14:15:00', true, 2, 2),
    (16.00, '2023-11-10 14:20:00', true, 2, 1),
    (18.00, '2023-11-10 14:25:00', true, 2, 3),
    (20.00, '2023-11-10 14:30:00', true, 2, 2);

-- Datos de prueba para la subasta 3 en la tabla "Bids"
INSERT INTO Bids (ammount, date, isWinner, Auctions_idAuction, Users_idUser)
VALUES
    (20.00, '2023-11-11 10:05:00', false, 3, 3),
    (22.00, '2023-11-11 10:10:00', false, 3, 2),
    (24.00, '2023-11-11 10:15:00', true, 3, 1),
    (26.00, '2023-11-11 10:20:00', true, 3, 3),
    (28.00, '2023-11-11 10:25:00', true, 3, 2),
    (30.00, '2023-11-11 10:30:00', true, 3, 1);
