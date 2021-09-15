-- MySQL Script generated by MySQL Workbench
-- 04/15/18 04:01:13
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Traffic Accident Reporting System
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Traffic Accident Reporting System` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Traffic Accident Reporting System` ;

-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Traffic Police Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Traffic Police Departments` (
  `department_code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` BIGINT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_code`),
  UNIQUE INDEX `department_code_UNIQUE` (`department_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Police Officers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Police Officers` (
  `badge_number` VARCHAR(45) NOT NULL,
  `Traffic Police Departments_department_code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `rank` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`badge_number`),
  UNIQUE INDEX `badge_number_UNIQUE` (`badge_number` ASC),
  INDEX `fk_Police Officers_Traffic Police Departments1_idx` (`Traffic Police Departments_department_code` ASC),
  CONSTRAINT `fk_Police Officers_Traffic Police Departments1`
    FOREIGN KEY (`Traffic Police Departments_department_code`)
    REFERENCES `Traffic Accident Reporting System`.`Traffic Police Departments` (`department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Companies` (
  `afm` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` BIGINT NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `mother_afm` INT NULL,
  PRIMARY KEY (`afm`),
  UNIQUE INDEX `afm_UNIQUE` (`afm` ASC),
  INDEX `fk_Companies_Companies1_idx` (`mother_afm` ASC),
  CONSTRAINT `fk_Companies_Companies1`
    FOREIGN KEY (`mother_afm`)
    REFERENCES `Traffic Accident Reporting System`.`Companies` (`afm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Dangerous Cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Dangerous Cargos` (
  `risk_code` VARCHAR(45) NOT NULL,
  `risk_class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`risk_code`),
  UNIQUE INDEX `risk_code_UNIQUE` (`risk_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Ware`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Ware` (
  `transfer_doc_number` VARCHAR(5) NOT NULL,
  `trade_company_afm` INT NOT NULL,
  `ware_type` VARCHAR(45) NOT NULL,
  `weight_total` FLOAT NOT NULL,
  `risk_code` VARCHAR(45) NULL,
  PRIMARY KEY (`transfer_doc_number`),
  UNIQUE INDEX `transfer_number_UNIQUE` (`transfer_doc_number` ASC),
  INDEX `fk_Ware_Companies1_idx` (`trade_company_afm` ASC),
  INDEX `fk_Ware_CargosDangerous1_idx` (`risk_code` ASC),
  CONSTRAINT `fk_Ware_Companies1`
    FOREIGN KEY (`trade_company_afm`)
    REFERENCES `Traffic Accident Reporting System`.`Companies` (`afm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ware_CargosDangerous1`
    FOREIGN KEY (`risk_code`)
    REFERENCES `Traffic Accident Reporting System`.`Dangerous Cargos` (`risk_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Hospitals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Hospitals` (
  `Code` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Code`),
  UNIQUE INDEX `hospital_code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Doctors` (
  `Hospitals_Code` VARCHAR(45) NOT NULL,
  `unique_code` VARCHAR(45) NOT NULL,
  `licince_number` VARCHAR(45) NOT NULL,
  `specialization` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`unique_code`, `Hospitals_Code`),
  UNIQUE INDEX `unique_code_UNIQUE` (`unique_code` ASC),
  INDEX `fk_Doctors_Hospitals1_idx` (`Hospitals_Code` ASC),
  CONSTRAINT `fk_Doctors_Hospitals1`
    FOREIGN KEY (`Hospitals_Code`)
    REFERENCES `Traffic Accident Reporting System`.`Hospitals` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Medical Procedures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Medical Procedures` (
  `code` INT NOT NULL,
  `description` TEXT NOT NULL,
  `body_parts` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `procedure_code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`ADT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`ADT` (
  `ADT` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` BIGINT NOT NULL,
  `birth_date` DATE NOT NULL,
  `afm` INT NOT NULL,
  `amka` BIGINT NOT NULL,
  PRIMARY KEY (`ADT`),
  UNIQUE INDEX `id_UNIQUE` (`ADT` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Driver Licences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Driver Licences` (
  `licence_number` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `iss_date` DATE NOT NULL,
  `ADT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`licence_number`),
  UNIQUE INDEX `licence_number_UNIQUE` (`licence_number` ASC),
  INDEX `fk_Driver Licences_ADT_idx` (`ADT` ASC),
  CONSTRAINT `fk_Driver Licences_ADT`
    FOREIGN KEY (`ADT`)
    REFERENCES `Traffic Accident Reporting System`.`ADT` (`ADT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Car Licences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Car Licences` (
  `plate_number` VARCHAR(10) NOT NULL,
  `frame_number` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `cubism` INT NOT NULL,
  `release_year` INT NOT NULL,
  `ADT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plate_number`),
  UNIQUE INDEX `plate_number_UNIQUE` (`plate_number` ASC),
  INDEX `fk_Car Licences_ADT1_idx` (`ADT` ASC),
  CONSTRAINT `fk_Car Licences_ADT1`
    FOREIGN KEY (`ADT`)
    REFERENCES `Traffic Accident Reporting System`.`ADT` (`ADT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Roads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Roads` (
  `road_part_code` VARCHAR(45) NOT NULL,
  `surface_type` VARCHAR(45) NOT NULL,
  `surface_condition` VARCHAR(45) NOT NULL,
  `speed_limit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`road_part_code`),
  UNIQUE INDEX `road_part_code_UNIQUE` (`road_part_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Police Reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Police Reports` (
  `dota_number` VARCHAR(45) NOT NULL,
  `report_editor` VARCHAR(45) NOT NULL,
  `regist_date` DATE NOT NULL,
  `report_reviewr` VARCHAR(45) NOT NULL,
  `review_date` DATE NOT NULL,
  `police_department` VARCHAR(10) NOT NULL,
  `description` TEXT NOT NULL,
  `GPS_latitude` POINT NOT NULL,
  `GPS_longitude` POINT NOT NULL,
  `roads_data` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dota_number`),
  UNIQUE INDEX `dota_number_UNIQUE` (`dota_number` ASC),
  INDEX `fk_Accidents_Roads1_idx` (`roads_data` ASC),
  INDEX `fk_Accidents_Police Officers1_idx` (`report_editor` ASC),
  INDEX `fk_Police Reports_Police Officers1_idx` (`report_reviewr` ASC, `police_department` ASC),
  CONSTRAINT `fk_Accidents_Roads1`
    FOREIGN KEY (`roads_data`)
    REFERENCES `Traffic Accident Reporting System`.`Roads` (`road_part_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accidents_Police Officers1`
    FOREIGN KEY (`report_editor`)
    REFERENCES `Traffic Accident Reporting System`.`Police Officers` (`badge_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Police Reports_Police Officers1`
    FOREIGN KEY (`report_reviewr` , `police_department`)
    REFERENCES `Traffic Accident Reporting System`.`Police Officers` (`badge_number` , `Traffic Police Departments_department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Involved Vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Involved Vehicles` (
  `dota_number` VARCHAR(45) NOT NULL,
  `serial_number` INT NOT NULL AUTO_INCREMENT,
  `car_licence` VARCHAR(10) NOT NULL,
  `bodywork_type` VARCHAR(45) NOT NULL,
  `estimated_speed` INT NOT NULL,
  `passengers_total` INT NOT NULL,
  `Ware_transfer_doc_number` VARCHAR(5) NULL,
  PRIMARY KEY (`dota_number`, `serial_number`),
  INDEX `fk_Involved Vehicles_Police Reports1_idx` (`dota_number` ASC),
  INDEX `fk_Involved Vehicles_Car Licences1_idx` (`car_licence` ASC),
  INDEX `fk_Involved Vehicles_Ware1_idx` (`Ware_transfer_doc_number` ASC),
  CONSTRAINT `fk_Involved Vehicles_Police Reports1`
    FOREIGN KEY (`dota_number`)
    REFERENCES `Traffic Accident Reporting System`.`Police Reports` (`dota_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Involved Vehicles_Car Licences1`
    FOREIGN KEY (`car_licence`)
    REFERENCES `Traffic Accident Reporting System`.`Car Licences` (`plate_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Involved Vehicles_Ware1`
    FOREIGN KEY (`Ware_transfer_doc_number`)
    REFERENCES `Traffic Accident Reporting System`.`Ware` (`transfer_doc_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Safety equiment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Safety equiment` (
  `Unique_code` INT NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Unique_code`),
  UNIQUE INDEX `Unique_code_UNIQUE` (`Unique_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Passenger `
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Passenger ` (
  `vehicle_serial_number` INT NOT NULL,
  `Position` INT NOT NULL,
  `Safety equiment_Unique_code` INT NOT NULL,
  PRIMARY KEY (`Position`, `vehicle_serial_number`),
  INDEX `fk_Passenger _Involved Vehicles1_idx` (`vehicle_serial_number` ASC),
  INDEX `fk_Passenger _Safety equiment1_idx` (`Safety equiment_Unique_code` ASC),
  CONSTRAINT `fk_Passenger _Involved Vehicles1`
    FOREIGN KEY (`vehicle_serial_number`)
    REFERENCES `Traffic Accident Reporting System`.`Involved Vehicles` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Passenger _Safety equiment1`
    FOREIGN KEY (`Safety equiment_Unique_code`)
    REFERENCES `Traffic Accident Reporting System`.`Safety equiment` (`Unique_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`KOK_violations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`KOK_violations` (
  `unique_code` INT NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`unique_code`),
  UNIQUE INDEX `unique_code_UNIQUE` (`unique_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Driver `
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Driver ` (
  `licence_number` VARCHAR(45) NOT NULL,
  `alcotest_type` VARCHAR(45) NOT NULL,
  `alcotest_time` TIME(12) NOT NULL,
  `alcotest_result` VARCHAR(45) NOT NULL,
  `KOK_violations_unique_code` INT NULL,
  INDEX `fk_Driver _KOK_violations1_idx` (`KOK_violations_unique_code` ASC),
  PRIMARY KEY (`licence_number`),
  INDEX `fk_Driver _Driver Licences1_idx` (`licence_number` ASC),
  UNIQUE INDEX `Driver Licences_licence_number_UNIQUE` (`licence_number` ASC),
  CONSTRAINT `fk_Driver _KOK_violations1`
    FOREIGN KEY (`KOK_violations_unique_code`)
    REFERENCES `Traffic Accident Reporting System`.`KOK_violations` (`unique_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Driver _Driver Licences1`
    FOREIGN KEY (`licence_number`)
    REFERENCES `Traffic Accident Reporting System`.`Driver Licences` (`licence_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Inserted`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Inserted` (
  `protocol_number` VARCHAR(45) NOT NULL,
  `dota_number` VARCHAR(45) NOT NULL,
  `ADT` VARCHAR(45) NOT NULL,
  `Hospitals_Code` VARCHAR(45) NOT NULL,
  `insertion_date_time` DATETIME NOT NULL,
  `discharge_date_time` DATETIME NOT NULL,
  `injury_severity` VARCHAR(45) NOT NULL,
  `injury_description` TEXT NOT NULL,
  PRIMARY KEY (`protocol_number`),
  INDEX `fk_Involved people_has_Hospitals_Hospitals1_idx` (`Hospitals_Code` ASC),
  CONSTRAINT `fk_Involved people_has_Hospitals_Hospitals1`
    FOREIGN KEY (`Hospitals_Code`)
    REFERENCES `Traffic Accident Reporting System`.`Hospitals` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Treated`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Treated` (
  `Inserted_protocol_number` VARCHAR(45) NOT NULL,
  `Doctors_unique_code` VARCHAR(45) NOT NULL,
  `Medical Procedures_code` INT NOT NULL,
  `treatment_duration` INT NOT NULL,
  `treatment_result` TEXT NOT NULL,
  PRIMARY KEY (`Inserted_protocol_number`),
  INDEX `fk_Doctors_has_Inserted_Inserted1_idx` (`Inserted_protocol_number` ASC),
  INDEX `fk_Doctors_has_Inserted_Doctors1_idx` (`Doctors_unique_code` ASC),
  INDEX `fk_Treated_Medical Procedures1_idx` (`Medical Procedures_code` ASC),
  CONSTRAINT `fk_Doctors_has_Inserted_Doctors1`
    FOREIGN KEY (`Doctors_unique_code`)
    REFERENCES `Traffic Accident Reporting System`.`Doctors` (`unique_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctors_has_Inserted_Inserted1`
    FOREIGN KEY (`Inserted_protocol_number`)
    REFERENCES `Traffic Accident Reporting System`.`Inserted` (`protocol_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treated_Medical Procedures1`
    FOREIGN KEY (`Medical Procedures_code`)
    REFERENCES `Traffic Accident Reporting System`.`Medical Procedures` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Status` (
  `code` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `Driver _licence_number` VARCHAR(45) NULL,
  `Passenger _vehicle_serial_number` INT NULL,
  `Passenger _Position` INT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `idStatus_UNIQUE` (`code` ASC),
  INDEX `fk_Status_Driver 2_idx` (`Driver _licence_number` ASC),
  INDEX `fk_Status_Passenger 2_idx` (`Passenger _Position` ASC, `Passenger _vehicle_serial_number` ASC),
  CONSTRAINT `fk_Status_Driver 2`
    FOREIGN KEY (`Driver _licence_number`)
    REFERENCES `Traffic Accident Reporting System`.`Driver ` (`licence_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Status_Passenger 2`
    FOREIGN KEY (`Passenger _Position` , `Passenger _vehicle_serial_number`)
    REFERENCES `Traffic Accident Reporting System`.`Passenger ` (`Position` , `vehicle_serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Involved People`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Involved People` (
  `dota_number` VARCHAR(45) NOT NULL,
  `serial_number` INT NOT NULL AUTO_INCREMENT,
  `Status_code` INT NOT NULL,
  `ADT` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `Hospitals_Code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`serial_number`, `dota_number`),
  INDEX `fk_Involved People_Status1_idx` (`Status_code` ASC),
  INDEX `fk_Involved People_Police Reports1_idx` (`dota_number` ASC),
  INDEX `fk_Involved People_ADT1_idx` (`ADT` ASC),
  INDEX `fk_Involved People_Inserted1_idx` (`Hospitals_Code` ASC),
  CONSTRAINT `fk_Involved People_Status1`
    FOREIGN KEY (`Status_code`)
    REFERENCES `Traffic Accident Reporting System`.`Status` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Involved People_Police Reports1`
    FOREIGN KEY (`dota_number`)
    REFERENCES `Traffic Accident Reporting System`.`Police Reports` (`dota_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Involved People_ADT1`
    FOREIGN KEY (`ADT`)
    REFERENCES `Traffic Accident Reporting System`.`ADT` (`ADT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Involved People_Inserted1`
    FOREIGN KEY (`Hospitals_Code`)
    REFERENCES `Traffic Accident Reporting System`.`Inserted` (`Hospitals_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Traffic Accident Reporting System`.`Reported`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Traffic Accident Reporting System`.`Reported` (
  `Companies_afm` INT NOT NULL,
  `protocol_number` VARCHAR(45) NOT NULL,
  `car_licence` VARCHAR(10) NOT NULL,
  `dota_number` VARCHAR(45) NOT NULL,
  `report_date` DATE NOT NULL,
  `estimatd_damage` TEXT NOT NULL,
  `estimated_cost` FLOAT NOT NULL,
  PRIMARY KEY (`Companies_afm`, `protocol_number`),
  INDEX `fk_Companies_has_Involved Vehicles_Involved Vehicles1_idx` (`dota_number` ASC, `car_licence` ASC),
  INDEX `fk_Companies_has_Involved Vehicles_Companies1_idx` (`Companies_afm` ASC),
  CONSTRAINT `fk_Companies_has_Involved Vehicles_Companies1`
    FOREIGN KEY (`Companies_afm`)
    REFERENCES `Traffic Accident Reporting System`.`Companies` (`afm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Companies_has_Involved Vehicles_Involved Vehicles1`
    FOREIGN KEY (`dota_number` , `car_licence`)
    REFERENCES `Traffic Accident Reporting System`.`Involved Vehicles` (`dota_number` , `car_licence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;