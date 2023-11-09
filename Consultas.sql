-- Usos en el endpoint de listar cartas para usuarios registrados
-- GET /api/v1/cards

SELECT
	auctions.idauction AS "ID Subasta", 
	cards."name" AS "Nombre cara", 
	cards.cardcode AS "Codigo carta", 
	cards.rarity AS "Rareza", 
	max_bid.ammount AS "Oferta", 
	auctions.startdate AS "Inicio", 
	auctions.enddate AS "Fin", 
	auctions.price AS "Precio Base", 
	cards.imglink AS "Imagen oficial", 
	images.imgupload AS "Imagen subida", 
	cards.marketprice AS "Precio Mercado", 
	auctions.issell AS "Venta", 
	city."name" AS "Ciudad"
FROM
	auctions
	INNER JOIN
	images
	ON 
		auctions.idauction = images.auctions_idauction
	INNER JOIN
	cards
	ON 
		auctions.cards_cardcode = cards.cardcode
	INNER JOIN
	city
	ON 
		auctions.city_idcity = city.idcity
	INNER JOIN
	(
		SELECT
			bids.auctions_idauction, 
			MAX(bids.ammount) AS ammount
		FROM
			bids
		GROUP BY
			bids.auctions_idauction
	) AS max_bid
	ON 
		auctions.idauction = max_bid.auctions_idauction
WHERE
	city."name" = 'City A' AND
	auctions.iscancelled = false;


-- Usos en el endpoint de listar cartas publico
-- GET /api/v1/cards (Sin Bearer JWT)

SELECT
	auctions.idauction AS "ID Subasta", 
	cards."name" AS "Nombre cara", 
	cards.cardcode AS "Codigo carta", 
	cards.rarity AS "Rareza", 
	auctions.startdate AS "Inicio", 
	auctions.enddate AS "Fin", 
	cards.imglink AS "Imagen oficial", 
	images.imgupload AS "Imagen subida", 
	auctions.issell AS "Venta", 
	city."name" AS "Ciudad"
FROM
	auctions
	INNER JOIN
	images
	ON 
		auctions.idauction = images.auctions_idauction
	INNER JOIN
	cards
	ON 
		auctions.cards_cardcode = cards.cardcode
	INNER JOIN
	city
	ON 
		auctions.city_idcity = city.idcity
WHERE
	city."name" = 'City A' AND
	auctions.iscancelled = false;

-- Usos en el endpoint de busqueda de cartas publico
-- GET /api/v1/cards?name=NombreBuscado (Sin Bearer JWT)

SELECT
	auctions.idauction AS "ID Subasta", 
	cards."name" AS "Nombre cara", 
	cards.cardcode AS "Codigo carta", 
	cards.rarity AS "Rareza", 
	auctions.startdate AS "Inicio", 
	auctions.enddate AS "Fin", 
	cards.imglink AS "Imagen oficial", 
	images.imgupload AS "Imagen subida", 
	auctions.issell AS "Venta", 
	city."name" AS "Ciudad"
FROM
	auctions
	INNER JOIN
	images
	ON 
		auctions.idauction = images.auctions_idauction
	INNER JOIN
	cards
	ON 
		auctions.cards_cardcode = cards.cardcode
	INNER JOIN
	city
	ON 
		auctions.city_idcity = city.idcity
WHERE
	city."name" = 'City A' AND
	auctions.iscancelled = false
 AND
	cards.cardcode = 'Codigo carta';

-- Usos en el endpoint de busqueda de cartas para usuarios registrados
-- GET /api/v1/cards?name=NombreBuscado

SELECT
	auctions.idauction AS "ID Subasta", 
	cards."name" AS "Nombre cara", 
	cards.cardcode AS "Codigo carta", 
	cards.rarity AS "Rareza", 
	max_bid.ammount AS "Oferta", 
	auctions.startdate AS "Inicio", 
	auctions.enddate AS "Fin", 
	auctions.price AS "Precio Base", 
	cards.imglink AS "Imagen oficial", 
	images.imgupload AS "Imagen subida", 
	cards.marketprice AS "Precio Mercado", 
	auctions.issell AS "Venta", 
	city."name" AS "Ciudad"
FROM
	auctions
	INNER JOIN
	images
	ON 
		auctions.idauction = images.auctions_idauction
	INNER JOIN
	cards
	ON 
		auctions.cards_cardcode = cards.cardcode
	INNER JOIN
	city
	ON 
		auctions.city_idcity = city.idcity
	INNER JOIN
	(
		SELECT
			bids.auctions_idauction, 
			MAX(bids.ammount) AS ammount
		FROM
			bids
		GROUP BY
			bids.auctions_idauction
	) AS max_bid
	ON 
		auctions.idauction = max_bid.auctions_idauction
WHERE
	city."name" = 'City A' AND
	auctions.iscancelled = false
 AND
	cards.cardcode = 'Codigo carta';