
CREATE SCHEMA UserManagement;

USE UserManagement;

CREATE TABLE `USER` (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    UserType VARCHAR(50),
    UserName VARCHAR(50),
    Password VARCHAR(50)
    
);

INSERT INTO USER (UserType, UserName, Password) VALUES
('Admin', 'admin_user', 'admin123'),
('Public', 'public_user', 'customer123'),
('Public', 'customer2', 'customer456'),
('Admin', 'superadmin', 'superadminpass'),
('Public', 'john_doe', 'john123'),
('Public', 'jane_doe', 'jane456'),
('Admin', 'manager1', 'manager123'),
('Admin', 'manager2', 'manager456'),
('Traffic', 'alice', 'alice123'),
('Traffic', 'bob', 'bob456');

ALTER TABLE `USER`
CHANGE COLUMN UserType USERTYPE VARCHAR(50),
CHANGE COLUMN UserName USERNAME VARCHAR(50),
CHANGE COLUMN Password PASSWORD VARCHAR(50);

Select * from User;

CREATE SCHEMA IotManagement;

USE IotManagement;


CREATE TABLE `IOT` (
    IOT_ID INT,
    LATITUDE FLOAT,
    LONGITUDE FLOAT,
    AHEAD_AADT VARCHAR(50),
    AHEAD_PEAK_HOUR VARCHAR(50),
    AHEAD_PEAK_MADT VARCHAR(50),
    BACK_AADT VARCHAR(50),
    BACK_PEAK_HOUR VARCHAR(50),
    BACK_PEAK_MADT VARCHAR(50),
    COUNTY VARCHAR(50),
    SCL VARCHAR(50),
    DISTRICT VARCHAR(50),
    LOCATION_DESCRIPTION VARCHAR(255),
    PM VARCHAR(50),
    PM_PFX VARCHAR(50),
    PM_SFX VARCHAR(50),
    ROUTE VARCHAR(50),
    ROUTE_SFX VARCHAR(50)
);

INSERT INTO IOT (IOT_ID, LATITUDE, LONGITUDE, AHEAD_AADT, AHEAD_PEAK_HOUR, AHEAD_PEAK_MADT, BACK_AADT, BACK_PEAK_HOUR, BACK_PEAK_MADT, COUNTY, SCL, DISTRICT, LOCATION_DESCRIPTION, PM, PM_PFX, PM_SFX, ROUTE, ROUTE_SFX) VALUES
(1, 37.3349, -121.8919, '67000', '6500', '72000', '155000', '15100', '167000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 280', '5.156', NULL, NULL, '87', NULL, NULL);


INSERT INTO IOT (IOT_ID, LATITUDE, LONGITUDE, AHEAD_AADT, AHEAD_PEAK_HOUR, AHEAD_PEAK_MADT, BACK_AADT, BACK_PEAK_HOUR, BACK_PEAK_MADT, COUNTY, SCL, DISTRICT, LOCATION_DESCRIPTION, PM, PM_PFX, PM_SFX, ROUTE, ROUTE_SFX) VALUES
(2, 37.3325, -121.8922, '72000', '7300', '78000', '162000', '15800', '174000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 87', '5.234', '', '', '280', '',''),
(3, 37.3357, -121.8889, '69000', '6700', '73000', '157000', '15300', '169000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 87', '5.379', '', '', '85', '',''),
(4, 37.3314, -121.8951, '71000', '6900', '75000', '160000', '15600', '172000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 85', '5.456', '', '', '101', '',''),
(5, 37.3352, -121.8848, '68000', '6600', '72000', '156000', '15200', '168000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 101', '5.642', '', '', '280', '',''),
(6, 37.3369, -121.8953, '70000', '6800', '74000', '159000', '15500', '171000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 280', '5.731', '', '', '85', '',''),
(7, 37.3329, -121.8902, '73000', '7100', '76000', '163000', '15900', '175000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 85', '5.845', '', '', '87', '',''),
(8, 37.3351, -121.8974, '69000', '6700', '73000', '157000', '15300', '169000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 87', '5.961', '', '', '101', '',''),
(9, 37.3382, -121.8938, '71000', '6900', '75000', '160000', '15600', '172000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 101', '6.074', '', '', '280', '',''),
(10, 37.3318, -121.8876, '72000', '7000', '76000', '163000', '15900', '175000', 'SCL', '4', 'SAN JOSE, JCT. RTE. 280', '6.188', '', '', '101', '','');

Select * from IOT;
------------


CREATE SCHEMA CctvManagement;

USE CctvManagement;

CREATE TABLE CCTV (
    CCTV_ID INT AUTO_INCREMENT,
    `index` INT,
    recordDate VARCHAR(255),
    Name VARCHAR(255),
    Type VARCHAR(255),
    Date DATE,
    recordTime TIME,
    recordEpoch BIGINT,
    district VARCHAR(255),
    locationName VARCHAR(255),
    nearbyPlace VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    elevation DOUBLE,
    direction VARCHAR(255),
    county VARCHAR(255),
    route VARCHAR(255),
    routeSuffix VARCHAR(255),
    postmilePrefix VARCHAR(255),
    postmile DOUBLE,
    alignment VARCHAR(255),
    milepost DOUBLE,
    inService VARCHAR(255),
    imageDescription VARCHAR(255),
    streamingVideoURL VARCHAR(255),
    currentImageUpdateFrequency VARCHAR(255),
    currentImageURL VARCHAR(255),
    PRIMARY KEY (CCTV_ID)
);

INSERT INTO CCTV (CCTV_ID, `index`, recordDate, Name, `Type`, Date, recordTime, recordEpoch, district, locationName, nearbyPlace, longitude, latitude, elevation, `direction`, county, route, routeSuffix, postmilePrefix, postmile, alignment, milepost, inService, imageDescription, streamingVideoURL, currentImageUpdateFrequency, currentImageURL) VALUES
(NULL, 664, '08/01/2024, 16:00', '', '', '2024-08-01', '16:54:39', 1704848079, '4', 'TV923 -- SR-87 : AT JCT 280', 'San Jose', -121.89, 37.32, 78.00, 'North', 'Santa Clara', 'SR-87', '', '', 5.08, 'R', 5.08, 'TRUE', '', 'https://cwwp2.dot.ca.gov/data/d4/cctv/image/tv923sr87atjct280/tv923sr87atjct280.jpg', '5', 'View');

INSERT INTO CCTV (`index`, recordDate, Name, `Type`, Date, recordTime, recordEpoch, district, locationName, nearbyPlace, longitude, latitude, elevation, `direction`, county, route, routeSuffix, postmilePrefix, postmile, alignment, milepost, inService, imageDescription, streamingVideoURL, currentImageUpdateFrequency, currentImageURL) VALUES
(664, '08/01/2024, 16:00', '', '', '2024-08-01', '16:54:39', 1704848079, '4', 'TV923 -- SR-87 : AT JCT 280', 'San Jose', -121.89, 37.32, 78.00, 'North', 'Santa Clara', 'SR-87', '', '', 5.08, 'R', 5.08, 'TRUE', '', 'https://cwwp2.dot.ca.gov/data/d4/cctv/image/tv923sr87atjct280/tv923sr87atjct280.jpg', '5', 'View'),
(259, '08/01/2024, 16:00', '', '', '2024-08-01', '17:19:45', 1704849585, '4', 'TVC37 -- I-280 : 10th Street', 'San Jose', -121.87, 37.33, 111.00, 'North', 'Santa Clara', 'I-280', '', '', 1.37, 'R', 1.37, 'TRUE', '', 'https://cwwp2.dot.ca.gov/data/d4/cctv/image/tvc37i28010thstreet/tvc37i28010thstreet.jpg', '5', 'View'),
(367, '09/07/2019, 17:00', '', '', '2019-09-07', '17:49:18', 1562806158, '4', 'TVC48 -- I-880 : SR-17 / I-280', 'San Jose', -121.94, 37.32, 121.00, '', 'Santa Clara', 'I-880', '', '', 0.17, '', 0.17, 'TRUE', '', 'https://wzmedia.dot.ca.gov/D4/N880_at_880_17_280.stream/playlist.m3u8', '5', 'View'),
(262, '09/07/2019, 17:00', '', '', '2019-09-07', '18:23:23', 1562808203, '4', 'TVB95 -- I-280 : Saratoga Avenue Onramp', 'San Jose', -121.98, 37.32, 131.00, 'South', 'Santa Clara', 'I-280', '', '', 5.95, '', 7.33, 'TRUE', '', 'https://cwwp2.dot.ca.gov/data/d4/cctv/image/tvb95i280saratogaavenueonramp/tvb95i280saratogaavenueonramp.jpg', '5', 'https://wzmedia.dot.ca.gov/D4/N880_at_880_17_280.stream/playlist.m3u8'),
(35, '26/09/2018, 17:00', '', '', '2018-09-26', '14:53:13', 1538085193, '4', 'TVC74 -- US-101 : North 1st Street Loop Onramp', 'San Jose', -121.92, 37.37, 42.00, 'South', 'Santa Clara', 'US-101', '', '', 39.29, '', 388.93, 'TRUE', '', 'https://cwwp2.dot.ca.gov/data/d4/cctv/image/tvc74us101north1ststreetlooponramp/tvc74us101north1ststreetlooponramp.jpg', '5', 'https://wzmedia.dot.ca.gov/D4/N101_at_N_1st_St.stream/playlist.m3u8');

Select * from CCTV;

ALTER TABLE IotManagement.IOT
ADD COLUMN STATUS ENUM('Active', 'Removed') DEFAULT 'Active';
ALTER TABLE UserManagement.USER
ADD COLUMN STATUS ENUM('Active', 'Removed') DEFAULT 'Active';
ALTER TABLE CctvManagement.CCTV
ADD COLUMN STATUS ENUM('Active', 'Removed') DEFAULT 'Active';

select * from CctvManagement.CCTV LIMIT 10;

select * from UserManagement.USER;

select * from IotManagement.IOT;

