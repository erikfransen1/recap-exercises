-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recapDb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema recapDb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recapDb` ;
USE `recapDb` ;

-- -----------------------------------------------------
-- Table `recapDb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`Medical` (
  `medicalField` VARCHAR(45) NOT NULL,
  `overtime rate` INT NULL,
  PRIMARY KEY (`medicalField`),
  UNIQUE INDEX `name_UNIQUE` (`medicalField` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`doctor` (
  `name` VARCHAR(45) NOT NULL,
  `DOB` DATE NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `salary` INT UNSIGNED NULL,
  `Medical_medicalField` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_doctor_Medical_idx` (`Medical_medicalField` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_Medical`
    FOREIGN KEY (`Medical_medicalField`)
    REFERENCES `recapDb`.`Medical` (`medicalField`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`specialist` (
  `specID` INT NOT NULL AUTO_INCREMENT,
  `field area` VARCHAR(45) NULL,
  `Medical_medicalField` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`specID`),
  INDEX `fk_specialist_Medical1_idx` (`Medical_medicalField` ASC) VISIBLE,
  CONSTRAINT `fk_specialist_Medical1`
    FOREIGN KEY (`Medical_medicalField`)
    REFERENCES `recapDb`.`Medical` (`medicalField`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`patient` (
  `idpatient` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `DOB` DATE NULL,
  PRIMARY KEY (`idpatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`appointment` (
  `idappointment` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `time` VARCHAR(45) NULL,
  `doctor_name` VARCHAR(45) NOT NULL,
  `patient_idpatient` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idappointment`, `patient_idpatient`),
  INDEX `fk_appointment_doctor1_idx` (`doctor_name` ASC) VISIBLE,
  INDEX `fk_appointment_patient1_idx` (`patient_idpatient` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_doctor1`
    FOREIGN KEY (`doctor_name`)
    REFERENCES `recapDb`.`doctor` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`patient_idpatient`)
    REFERENCES `recapDb`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`Bill` (
  `idBill` VARCHAR(45) NOT NULL,
  `total` INT NULL,
  `patient_idpatient` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBill`),
  INDEX `fk_Bill_patient1_idx` (`patient_idpatient` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_patient1`
    FOREIGN KEY (`patient_idpatient`)
    REFERENCES `recapDb`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`Payment` (
  `idPayment` VARCHAR(45) NOT NULL,
  `Method` VARCHAR(45) NULL,
  `Details` VARCHAR(45) NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recapDb`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recapDb`.`Bill_has_Payment` (
  `Bill_idBill` VARCHAR(45) NOT NULL,
  `Payment_idPayment` VARCHAR(45) NOT NULL,
  `id_Bill_Payment` VARCHAR(45) NOT NULL,
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_idBill` ASC) VISIBLE,
  PRIMARY KEY (`id_Bill_Payment`),
  UNIQUE INDEX `id_Bill_Payment_UNIQUE` (`id_Bill_Payment` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_idBill`)
    REFERENCES `recapDb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `recapDb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
