Create database TABLASERIE;
USE TABLASERIE;

--Creacion de la tabla--
create table tablaSerie(
idTS int not null,
TerminoTS int not null,
constraint PK_tablaSerie primary key (idTS)
);

--Procedimiento para gaurdar datos automaticos
create PROCEDURE sn_guardarTablaSerie
    @n INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM tablaSerie; 
        BEGIN TRANSACTION;

        DECLARE @valor int;
        DECLARE @cont INT;

        SET @cont = 1; 
        SET @valor = 1; 

        WHILE @cont <= @n 
	       BEGIN
            IF @valor % 2  = 0 
            BEGIN
                SET @valor = @valor - 2 ;  
            END
            ELSE  
            BEGIN
                SET @valor = @valor + 4 ;  
            END
            -- Insertar el valor en la tabla
            INSERT INTO tablaSerie
            VALUES (@cont,@valor);
            SET @cont = @cont + 1;
		END
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Ingreso la cantidad de datos en los cuales realizare el programa--
Exec sn_guardarTablaSerie 5

	--verifica --
	select * from tablaSerie

