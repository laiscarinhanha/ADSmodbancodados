-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `hist_prod` VARCHAR(45) NOT NULL,
  `tipo_prod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduto`, `hist_prod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estoque` (
  `idestoque` INT NOT NULL AUTO_INCREMENT,
  `quant_prod` VARCHAR(45) NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Produto_hist_prod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestoque`, `Produto_idProduto`, `Produto_hist_prod`),
  INDEX `fk_estoque_Produto1_idx` (`Produto_idProduto` ASC, `Produto_hist_prod` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto` , `Produto_hist_prod`)
    REFERENCES `mydb`.`Produto` (`idProduto` , `hist_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sub_hig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sub_hig` (
  `idsub_hig` INT NOT NULL,
  `limpeza` VARCHAR(45) NOT NULL,
  `hig_pessaol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsub_hig`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`higiene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`higiene` (
  `idhigiene` INT NOT NULL AUTO_INCREMENT,
  `sub_hig_idsub_hig` INT NOT NULL,
  PRIMARY KEY (`idhigiene`, `sub_hig_idsub_hig`),
  INDEX `fk_higiene_sub_hig1_idx` (`sub_hig_idsub_hig` ASC) VISIBLE,
  CONSTRAINT `fk_higiene_sub_hig1`
    FOREIGN KEY (`sub_hig_idsub_hig`)
    REFERENCES `mydb`.`sub_hig` (`idsub_hig`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sub_alimen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sub_alimen` (
  `idsub_alimen` INT NOT NULL AUTO_INCREMENT,
  `solidos` VARCHAR(45) NOT NULL,
  `bebidas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsub_alimen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alimenticio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alimenticio` (
  `id_ali` INT NOT NULL AUTO_INCREMENT,
  `sub_alimen_idsub_alimen` INT NOT NULL,
  PRIMARY KEY (`id_ali`, `sub_alimen_idsub_alimen`),
  INDEX `fk_alimenticio_sub_alimen1_idx` (`sub_alimen_idsub_alimen` ASC) VISIBLE,
  CONSTRAINT `fk_alimenticio_sub_alimen1`
    FOREIGN KEY (`sub_alimen_idsub_alimen`)
    REFERENCES `mydb`.`sub_alimen` (`idsub_alimen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sub_hortif`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sub_hortif` (
  `idsubtipos` INT NOT NULL AUTO_INCREMENT,
  `sub_verdura` VARCHAR(45) NOT NULL,
  `sub_fruta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsubtipos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hortifruti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hortifruti` (
  `id_horti` INT NOT NULL AUTO_INCREMENT,
  `sub_hortif_idsubtipos` INT NOT NULL,
  PRIMARY KEY (`id_horti`, `sub_hortif_idsubtipos`),
  INDEX `fk_hortifruti_sub_hortif1_idx` (`sub_hortif_idsubtipos` ASC) VISIBLE,
  CONSTRAINT `fk_hortifruti_sub_hortif1`
    FOREIGN KEY (`sub_hortif_idsubtipos`)
    REFERENCES `mydb`.`sub_hortif` (`idsubtipos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venda` (
  `idvenda` INT NOT NULL AUTO_INCREMENT,
  `cupom_fiscal` VARCHAR(45) NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`idvenda`, `cupom_fiscal`, `Produto_idProduto`),
  INDEX `fk_venda_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_venda_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `idcompra` INT NOT NULL AUTO_INCREMENT,
  `cpf_cli` VARCHAR(45) NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`idcompra`, `Produto_idProduto`),
  INDEX `fk_compra_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_compra_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hortifruti_has_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hortifruti_has_Produto` (
  `hortifruti_id_horti` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Produto_estoque_idestoque` INT NOT NULL,
  PRIMARY KEY (`hortifruti_id_horti`, `Produto_idProduto`, `Produto_estoque_idestoque`),
  INDEX `fk_hortifruti_has_Produto_Produto1_idx` (`Produto_idProduto` ASC, `Produto_estoque_idestoque` ASC) VISIBLE,
  INDEX `fk_hortifruti_has_Produto_hortifruti1_idx` (`hortifruti_id_horti` ASC) VISIBLE,
  CONSTRAINT `fk_hortifruti_has_Produto_hortifruti1`
    FOREIGN KEY (`hortifruti_id_horti`)
    REFERENCES `mydb`.`hortifruti` (`id_horti`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hortifruti_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alimenticio_has_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alimenticio_has_Produto` (
  `alimenticio_id_ali` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Produto_estoque_idestoque` INT NOT NULL,
  PRIMARY KEY (`alimenticio_id_ali`, `Produto_idProduto`, `Produto_estoque_idestoque`),
  INDEX `fk_alimenticio_has_Produto_Produto1_idx` (`Produto_idProduto` ASC, `Produto_estoque_idestoque` ASC) VISIBLE,
  INDEX `fk_alimenticio_has_Produto_alimenticio1_idx` (`alimenticio_id_ali` ASC) VISIBLE,
  CONSTRAINT `fk_alimenticio_has_Produto_alimenticio1`
    FOREIGN KEY (`alimenticio_id_ali`)
    REFERENCES `mydb`.`alimenticio` (`id_ali`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alimenticio_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_has_higiene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_has_higiene` (
  `Produto_idProduto` INT NOT NULL,
  `Produto_estoque_idestoque` INT NOT NULL,
  `higiene_idhigiene` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Produto_estoque_idestoque`, `higiene_idhigiene`),
  INDEX `fk_Produto_has_higiene_higiene1_idx` (`higiene_idhigiene` ASC) VISIBLE,
  INDEX `fk_Produto_has_higiene_Produto1_idx` (`Produto_idProduto` ASC, `Produto_estoque_idestoque` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_higiene_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_higiene_higiene1`
    FOREIGN KEY (`higiene_idhigiene`)
    REFERENCES `mydb`.`higiene` (`idhigiene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
