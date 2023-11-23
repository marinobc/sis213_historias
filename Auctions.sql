-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-11-23 01:29:53.211

-- tables
-- Table: Auctions
CREATE TABLE Auctions (
    idAuction serial  NOT NULL,
    Users_idUser int  NOT NULL,
    Cards_idCard int  NOT NULL,
    City_idCity int  NOT NULL,
    startDate time  NOT NULL,
    endDate time  NULL,
    Price decimal(10,2)  NOT NULL,
    isSell boolean  NOT NULL,
    isCancelled boolean  NOT NULL,
    CONSTRAINT Auctions_pk PRIMARY KEY (idAuction)
);

-- Table: Bids
CREATE TABLE Bids (
    idBid serial  NOT NULL,
    Auctions_idAuction int  NOT NULL,
    Users_idUser int  NOT NULL,
    ammount decimal(10,2)  NOT NULL,
    date time  NOT NULL,
    isWinner boolean  NOT NULL,
    CONSTRAINT Bids_pk PRIMARY KEY (idBid)
);

-- Table: Cards
CREATE TABLE Cards (
    idCard serial  NOT NULL,
    cardCode char(32)  NOT NULL,
    rarity char(64)  NOT NULL,
    name char(128)  NOT NULL,
    imgLink char(32)  NOT NULL,
    marketPrice decimal(10,2)  NOT NULL,
    CONSTRAINT Cards_pk PRIMARY KEY (idCard)
);

-- Table: City
CREATE TABLE City (
    idCity serial  NOT NULL,
    name char(32)  NOT NULL,
    CONSTRAINT City_pk PRIMARY KEY (idCity)
);

-- Table: H_Bids
CREATE TABLE H_Bids (
    h_id_Bids serial  NOT NULL,
    Bids_idBids int  NOT NULL,
    User_idUser int  NOT NULL,
    ammount decimal(10,2)  NOT NULL,
    date time  NOT NULL,
    isWinner boolean  NOT NULL,
    CONSTRAINT H_Bids_pk PRIMARY KEY (h_id_Bids)
);

-- Table: H_Owners
CREATE TABLE H_Owners (
    id_h_owners serial  NOT NULL,
    Owners_idOwners int  NOT NULL,
    User_idUser int  NOT NULL,
    Cards_cardCode int  NOT NULL,
    acquired time  NOT NULL,
    CONSTRAINT H_Owners_pk PRIMARY KEY (id_h_owners)
);

-- Table: Images
CREATE TABLE Images (
    idImages serial  NOT NULL,
    Auctions_idAuction int  NOT NULL,
    imgUpload char(64)  NOT NULL,
    CONSTRAINT Images_pk PRIMARY KEY (idImages)
);

-- Table: Owners
CREATE TABLE Owners (
    idOwner serial  NOT NULL,
    Users_idUser int  NOT NULL,
    Cards_idCard int  NOT NULL,
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
    FOREIGN KEY (Cards_idCard)
    REFERENCES Cards (idCard)  
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
    FOREIGN KEY (Cards_idCard)
    REFERENCES Cards (idCard)  
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

-- Triggers
-- Trigger: trigger_h_owners
CREATE OR REPLACE FUNCTION trigger_h_bids()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO H_Bids (Bids_idBids, User_idUser, ammount, date, isWinner)
    VALUES (NEW.idBid, NEW.Users_idUser, NEW.ammount, NEW.date, NEW.isWinner);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER h_bids_trigger
AFTER INSERT ON Bids
FOR EACH ROW
EXECUTE FUNCTION trigger_h_bids();

-- Trigger: trigger_h_owners
CREATE OR REPLACE FUNCTION trigger_h_owners()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO H_Owners (Owners_idOwners, User_idUser, Cards_cardCode, acquired)
    VALUES (NEW.idOwner, NEW.Users_idUser, NEW.Cards_idCard, NEW.acquired);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER h_owners_trigger
AFTER INSERT ON Owners
FOR EACH ROW
EXECUTE FUNCTION trigger_h_owners();

