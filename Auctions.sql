-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-11-09 18:48:34.617

-- tables
-- Table: Auctions
CREATE TABLE Auctions (
    idAuction serial  NOT NULL,
    startDate time  NOT NULL,
    endDate time  NULL,
    Price decimal(10,2)  NOT NULL,
    isSell boolean  NOT NULL,
    isCancelled boolean  NOT NULL,
    Cards_cardCode char(32)  NOT NULL,
    Users_idUser int  NOT NULL,
    City_idCity int  NOT NULL,
    CONSTRAINT Auctions_pk PRIMARY KEY (idAuction)
);

-- Table: Bids
CREATE TABLE Bids (
    idBid serial  NOT NULL,
    ammount decimal(10,2)  NOT NULL,
    date time  NOT NULL,
    isWinner boolean  NOT NULL,
    Auctions_idAuction int  NOT NULL,
    Users_idUser int  NOT NULL,
    CONSTRAINT Bids_pk PRIMARY KEY (idBid)
);

-- Table: Cards
CREATE TABLE Cards (
    cardCode char(32)  NOT NULL,
    rarity char(64)  NOT NULL,
    name char(128)  NOT NULL,
    imgLink char(32)  NOT NULL,
    marketPrice decimal(10,2)  NOT NULL,
    CONSTRAINT Cards_pk PRIMARY KEY (cardCode)
);

-- Table: City
CREATE TABLE City (
    idCity serial  NOT NULL,
    name char(32)  NOT NULL,
    CONSTRAINT City_pk PRIMARY KEY (idCity)
);

-- Table: Images
CREATE TABLE Images (
    idImages serial  NOT NULL,
    imgUpload char(64)  NOT NULL,
    Auctions_idAuction int  NOT NULL,
    CONSTRAINT Images_pk PRIMARY KEY (idImages)
);

-- Table: Owners
CREATE TABLE Owners (
    idOwner serial  NOT NULL,
    Users_idUser int  NOT NULL,
    Cards_cardCode char(32)  NOT NULL,
    acquired time  NOT NULL,
    CONSTRAINT Owners_pk PRIMARY KEY (idOwner)
);

-- Table: Users
CREATE TABLE Users (
    idUser serial  NOT NULL,
    name char(64)  NOT NULL,
    CONSTRAINT Users_pk PRIMARY KEY (idUser)
);

-- foreign keys
-- Reference: Auctions_Cards (table: Auctions)
ALTER TABLE Auctions ADD CONSTRAINT Auctions_Cards
    FOREIGN KEY (Cards_cardCode)
    REFERENCES Cards (cardCode)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Auctions_City (table: Auctions)
ALTER TABLE Auctions ADD CONSTRAINT Auctions_City
    FOREIGN KEY (City_idCity)
    REFERENCES City (idCity)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Auctions_Users (table: Auctions)
ALTER TABLE Auctions ADD CONSTRAINT Auctions_Users
    FOREIGN KEY (Users_idUser)
    REFERENCES Users (idUser)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Bids_Auctions (table: Bids)
ALTER TABLE Bids ADD CONSTRAINT Bids_Auctions
    FOREIGN KEY (Auctions_idAuction)
    REFERENCES Auctions (idAuction)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Bids_Users (table: Bids)
ALTER TABLE Bids ADD CONSTRAINT Bids_Users
    FOREIGN KEY (Users_idUser)
    REFERENCES Users (idUser)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Images_Auctions (table: Images)
ALTER TABLE Images ADD CONSTRAINT Images_Auctions
    FOREIGN KEY (Auctions_idAuction)
    REFERENCES Auctions (idAuction)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Owners_Cards (table: Owners)
ALTER TABLE Owners ADD CONSTRAINT Owners_Cards
    FOREIGN KEY (Cards_cardCode)
    REFERENCES Cards (cardCode)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Owners_Users (table: Owners)
ALTER TABLE Owners ADD CONSTRAINT Owners_Users
    FOREIGN KEY (Users_idUser)
    REFERENCES Users (idUser)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

