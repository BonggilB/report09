-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 민혁대학
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 민혁대학
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `민혁대학` DEFAULT CHARACTER SET utf8 ;
USE `민혁대학` ;

-- -----------------------------------------------------
-- Table `민혁대학`.`교수`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `민혁대학`.`교수` (
  `교수번호` VARCHAR(11) NOT NULL,
  `교수이름` VARCHAR(20) NOT NULL,
  `교수주민번호` VARCHAR(20) NOT NULL,
  `교수전화번호` VARCHAR(20) NOT NULL,
  `교수이메일` VARCHAR(45) NOT NULL,
  `소속학과번호` VARCHAR(20) NOT NULL,
  `학과_학과번호` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`교수번호`),
  UNIQUE INDEX `교수주민번호_UNIQUE` (`교수주민번호` ASC) VISIBLE,
  UNIQUE INDEX `교수전화번호_UNIQUE` (`교수전화번호` ASC) VISIBLE,
  UNIQUE INDEX `교수이메일_UNIQUE` (`교수이메일` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `민혁대학`.`강좌`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `민혁대학`.`강좌` (
  `강좌번호` VARCHAR(20) NOT NULL,
  `강좌명` VARCHAR(20) NOT NULL,
  `취득학점` VARCHAR(20) NOT NULL,
  `강의시간` VARCHAR(20) NOT NULL,
  `강의실` VARCHAR(20) NOT NULL,
  `담당교수번호` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`강좌번호`),
  UNIQUE INDEX `강좌명_UNIQUE` (`강좌명` ASC) VISIBLE,
  INDEX `fk_강좌_교수1_idx` (`담당교수번호` ASC) VISIBLE,
  CONSTRAINT `fk_강좌_교수1`
    FOREIGN KEY (`담당교수번호`)
    REFERENCES `민혁대학`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `민혁대학`.`학생`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `민혁대학`.`학생` (
  `학번` VARCHAR(8) NOT NULL,
  `이름` VARCHAR(20) NOT NULL,
  `주민등록번호` VARCHAR(14) NOT NULL,
  `주소` VARCHAR(40) NOT NULL,
  `전화번호` VARCHAR(15) NOT NULL,
  `이메일` VARCHAR(30) NOT NULL,
  `학과번호` VARCHAR(20) NOT NULL,
  `교수번호` VARCHAR(11) NOT NULL,
  `학과_학과번호` VARCHAR(20) NOT NULL,
  `강좌_강좌번호` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`학번`, `교수번호`),
  UNIQUE INDEX `주민등록번호_UNIQUE` (`주민등록번호` ASC) VISIBLE,
  INDEX `fk_학생_교수_idx` (`교수번호` ASC) VISIBLE,
  UNIQUE INDEX `전화번호_UNIQUE` (`전화번호` ASC) VISIBLE,
  UNIQUE INDEX `이메일_UNIQUE` (`이메일` ASC) VISIBLE,
  INDEX `fk_학생_강좌1_idx` (`강좌_강좌번호` ASC) VISIBLE,
  CONSTRAINT `fk_학생_교수`
    FOREIGN KEY (`교수번호`)
    REFERENCES `민혁대학`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_학생_강좌1`
    FOREIGN KEY (`강좌_강좌번호`)
    REFERENCES `민혁대학`.`강좌` (`강좌번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `민혁대학`.`수강내역`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `민혁대학`.`수강내역` (
  `출석점수` VARCHAR(20) NOT NULL,
  `중간고사점수` VARCHAR(20) NOT NULL,
  `기말고사점수` VARCHAR(20) NOT NULL,
  `기타점수` VARCHAR(20) NOT NULL,
  `총점` VARCHAR(20) NOT NULL,
  `평점` VARCHAR(20) NOT NULL,
  `학생_학번` VARCHAR(8) NOT NULL,
  `학생_교수번호` VARCHAR(11) NOT NULL,
  `교수_교수번호` VARCHAR(11) NOT NULL,
  INDEX `fk_수강내역_학생1_idx` (`학생_학번` ASC, `학생_교수번호` ASC) VISIBLE,
  INDEX `fk_수강내역_교수1_idx` (`교수_교수번호` ASC) VISIBLE,
  CONSTRAINT `fk_수강내역_학생1`
    FOREIGN KEY (`학생_학번` , `학생_교수번호`)
    REFERENCES `민혁대학`.`학생` (`학번` , `교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_수강내역_교수1`
    FOREIGN KEY (`교수_교수번호`)
    REFERENCES `민혁대학`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `민혁대학`.`학과`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `민혁대학`.`학과` (
  `교수_교수번호` VARCHAR(11) NOT NULL,
  `학생_학번` VARCHAR(8) NOT NULL,
  `학생_교수번호` VARCHAR(11) NOT NULL,
  `학과번호` VARCHAR(20) NOT NULL,
  `학과명` VARCHAR(20) NOT NULL,
  `학과전화번호` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`교수_교수번호`, `학생_학번`, `학생_교수번호`, `학과번호`),
  INDEX `fk_교수_has_학생_학생1_idx` (`학생_학번` ASC, `학생_교수번호` ASC) VISIBLE,
  INDEX `fk_교수_has_학생_교수1_idx` (`교수_교수번호` ASC) VISIBLE,
  CONSTRAINT `fk_교수_has_학생_교수1`
    FOREIGN KEY (`교수_교수번호`)
    REFERENCES `민혁대학`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_교수_has_학생_학생1`
    FOREIGN KEY (`학생_학번` , `학생_교수번호`)
    REFERENCES `민혁대학`.`학생` (`학번` , `교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
