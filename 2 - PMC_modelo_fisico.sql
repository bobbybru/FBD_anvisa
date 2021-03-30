-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema anvisa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema anvisa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `anvisa` DEFAULT CHARACTER SET utf8 ;
USE `anvisa` ;

-- -----------------------------------------------------
-- Table `anvisa`.`Laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anvisa`.`Laboratorio` (
  `cnpj` VARCHAR(25) NOT NULL,
  `nome` VARCHAR(150) NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `anvisa`.`Registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anvisa`.`Registro` (
  `idRegistro` BIGINT(20) NULL,
  `CD_GGEREM` BIGINT(30) NOT NULL,
  PRIMARY KEY (`CD_GGEREM`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `anvisa`.`Medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anvisa`.`Medicamento` (
  `principio_ativo` VARCHAR(300) NOT NULL,
  `apresentacao` VARCHAR(150) NOT NULL,
  `produto` VARCHAR(150) NOT NULL,
  `tarja` VARCHAR(150) NULL,
  `tipo_produto` VARCHAR(150) NULL,
  `Registro_CD_GGEREM` BIGINT(30) NOT NULL,
  PRIMARY KEY (`principio_ativo`, `apresentacao`, `Registro_CD_GGEREM`, `produto`),
  INDEX `fk_Medicamento_Registro1_idx` (`Registro_CD_GGEREM` ASC) VISIBLE,
  CONSTRAINT `fk_Medicamento_Registro1`
    FOREIGN KEY (`Registro_CD_GGEREM`)
    REFERENCES `anvisa`.`Registro` (`CD_GGEREM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `anvisa`.`Preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anvisa`.`Preco` (
  `ean_1` BIGINT(15) NOT NULL,
  `ean_2` BIGINT(15) NOT NULL,
  `ean_3` BIGINT(15) NOT NULL,
  `ls_pis_cofins` VARCHAR(45) NULL,
  `pf` FLOAT NULL,
  `pmc` FLOAT NULL,
  `Medicamento_principio_ativo` VARCHAR(300) NOT NULL,
  `Medicamento_apresentacao` VARCHAR(150) NOT NULL,
  `Medicamento_Registro_CD_GGEREM` BIGINT(30) NOT NULL,
  `Medicamento_produto` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`ean_1`, `ean_2`, `ean_3`),
  INDEX `fk_Preco_Medicamento1_idx` (`Medicamento_principio_ativo` ASC, `Medicamento_apresentacao` ASC, `Medicamento_Registro_CD_GGEREM` ASC, `Medicamento_produto` ASC) VISIBLE,
  CONSTRAINT `fk_Preco_Medicamento1`
    FOREIGN KEY (`Medicamento_principio_ativo` , `Medicamento_apresentacao` , `Medicamento_Registro_CD_GGEREM` , `Medicamento_produto`)
    REFERENCES `anvisa`.`Medicamento` (`principio_ativo` , `apresentacao` , `Registro_CD_GGEREM` , `produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `anvisa`.`Laboratorio_has_Medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anvisa`.`Laboratorio_has_Medicamento` (
  `Laboratorio_cnpj` VARCHAR(25) NOT NULL,
  `Medicamento_principio_ativo` VARCHAR(300) NOT NULL,
  `Medicamento_apresentacao` VARCHAR(150) NOT NULL,
  `Medicamento_Registro_CD_GGEREM` BIGINT(30) NOT NULL,
  `Medicamento_produto` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`Laboratorio_cnpj`, `Medicamento_principio_ativo`, `Medicamento_apresentacao`, `Medicamento_Registro_CD_GGEREM`, `Medicamento_produto`),
  INDEX `fk_Laboratorio_has_Medicamento_Medicamento1_idx` (`Medicamento_principio_ativo` ASC, `Medicamento_apresentacao` ASC, `Medicamento_Registro_CD_GGEREM` ASC, `Medicamento_produto` ASC) VISIBLE,
  INDEX `fk_Laboratorio_has_Medicamento_Laboratorio1_idx` (`Laboratorio_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratorio_has_Medicamento_Laboratorio1`
    FOREIGN KEY (`Laboratorio_cnpj`)
    REFERENCES `anvisa`.`Laboratorio` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Laboratorio_has_Medicamento_Medicamento1`
    FOREIGN KEY (`Medicamento_principio_ativo` , `Medicamento_apresentacao` , `Medicamento_Registro_CD_GGEREM` , `Medicamento_produto`)
    REFERENCES `anvisa`.`Medicamento` (`principio_ativo` , `apresentacao` , `Registro_CD_GGEREM` , `produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
