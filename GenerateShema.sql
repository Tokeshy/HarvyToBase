-- MySQL Script generated by MySQL Workbench
-- Fri Jul  8 11:55:12 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IceTradeSch
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `IceTradeSch` ;

-- -----------------------------------------------------
-- Schema IceTradeSch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IceTradeSch` DEFAULT CHARACTER SET utf8 ;
USE `IceTradeSch` ;

-- -----------------------------------------------------
-- Table `IceTradeSch`.`GeneralInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IceTradeSch`.`GeneralInfo` ;

CREATE TABLE IF NOT EXISTS `IceTradeSch`.`GeneralInfo` (
  `LinkID` INT NOT NULL COMMENT 'link postfix as unique deal id',
  `DealID` VARCHAR(64) NOT NULL COMMENT 'Deal number in IceTrade structure',
  `StatusInfo` VARCHAR(128) NULL COMMENT 'general information about the type of transaction',
  `Industry` VARCHAR(384) NOT NULL COMMENT 'industry of lot(s)',
  `ShortDesc` VARCHAR(768) NULL COMMENT 'Short description for lot and deal',
  PRIMARY KEY (`LinkID`),
  UNIQUE INDEX `ID_UNIQUE` (`LinkID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IceTradeSch`.`DealDetailedInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IceTradeSch`.`DealDetailedInfo` ;

CREATE TABLE IF NOT EXISTS `IceTradeSch`.`DealDetailedInfo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `LinkID` INT NOT NULL,
  `PropertyName` VARCHAR(64) NOT NULL,
  `PropNameExt` VARCHAR(128) NOT NULL,
  `PropertyValue` VARCHAR(384) NOT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IceTradeSch`.`badlinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IceTradeSch`.`badlinks` ;

CREATE TABLE IF NOT EXISTS `IceTradeSch`.`badlinks` (
  `ID` INT NOT NULL COMMENT 'Simple inner ID',
  `BadLinkID` INT NOT NULL COMMENT 'Bad link w no response (404)',
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `BadLinkID_UNIQUE` (`BadLinkID` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS HarvyToBase;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'HarvyToBase' IDENTIFIED BY 'Harvy_Pas$)';

GRANT SELECT, INSERT, TRIGGER ON TABLE `IceTradeSch`.* TO 'HarvyToBase';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `IceTradeSch`.* TO 'HarvyToBase';
GRANT EXECUTE ON ROUTINE `IceTradeSch`.* TO 'HarvyToBase';
GRANT SELECT ON TABLE `IceTradeSch`.* TO 'HarvyToBase';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
