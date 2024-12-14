
-- Verificar Usuario

Create PROCEDURE ps_Verificacion
   @username varchar(60), --Nombre del Usuario en Acceso
   @llave varchar(60) --Clave del Usuario en Acceso
AS
BEGIN
    BEGIN TRY 
		declare @userd varchar(60)
		set @userd = (select llave from Acceso where username = @username)
		IF (@userd  != @llave)
			BEGIN
				PRINT 0;
				Return;
			END;
		ELSE
			BEGIN
			select idUser from Acceso where username = @username and llave= @llave
				Return;
			END;
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH;
END;

-- Maneras de seleccionar Proyectos

CREATE PROCEDURE sp_ALL_PROYECTOS
	--Selecciona de manera general los datos
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		Select * from Proyecto
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Seleccionar Catalogo del Proyecto

Create PROCEDURE sp_Select_Catalogo
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		select nombreTP from TipoProyecto;
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Seleccionar Por Tipo del Proyecto
Create PROCEDURE sp_Tipos_Proyectos
@nombreTP varchar(60)
AS
BEGIN
    BEGIN TRY 
		declare @idTP int
        BEGIN TRANSACTION;
		set @idTP = (select idTP from TipoProyecto where nombreTP = @nombreTP)
		select * from Proyecto where idTP = @idTP
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;


-- Selecion especifica de proyectos

CREATE PROCEDURE sn_Select_PROYECTOS
   @TipoProyect int --Es para Seleccionar el TIPO de Poryecto al cual va el proyecto
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		Select * from Proyecto where idTP = @TipoProyect
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

-- Agregar un  proyecto

Alter PROCEDURE sp_AddProyect
    @nombreTP varchar(60) , --Es para Seleccionar el TIPO de Poryecto al cual va el proyecto
	@nmProy varchar(255) , --Se ingresa el nombre del proyecto
	 @descProy varchar(1024) --Se ingresa la descripcion
AS
BEGIN
    BEGIN TRY 
		declare @idTP int;
        BEGIN TRANSACTION;
		set @idTP = (Select top 1 idTP from TipoProyecto where nombreTP = @nombreTP order by idTP desc);
		insert into Proyecto values (@nmProy ,@descProy ,@idTP) ;
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH;
END;

-- Consultar Anexos a un  proyecto

CREATE PROCEDURE sp_AnexosProyect
    @nombreProyecto varchar(60) --Es para visualizar el nombre del proyecto y su catalogo Respectivo
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		Select Tpr.nombreTP as "Catalogo del proyecto" , pr.nombreProy as "Nombre del Proyecto" from Proyecto pr,TipoProyecto Tpr where pr.nombreProy = @nombreProyecto  and pr.idTP = Tpr.idTP 
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH;
END;
Select * from Proyecto
Select * from Anexo_Proyecto

---Nuevo
CREATE PROCEDURE sp_DetalleProyecto
    @idProy int --Es para visualizar el nombre del proyecto y su catalogo Respectivo
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		Select indicacion,fecha,estado from Anexo_Proyecto where idProy =  @idProy
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH;
END;



Execute sp_DetalleProyecto 3

-- Actualizar Proyecto

Create PROCEDURE sp_UpdateProyect
   @idProy int, --Id del Proyecto
   @nombreProy varchar(255), --Nombre del proyecto
   @descProy varchar(1024) --Descripcion del mismo
AS
BEGIN
    BEGIN TRY 
		update Proyecto  SET descProy = @descProy,  nombreProy= @nombreProy where nombreProy = @nombreProy and idProy = @idProy;
		Print 1;
		return;
		COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

-- Ingresar Datos en los Anexos Proyecto

Create PROCEDURE sp_UpdateAnexo_Proyecto
   @indicación varchar(1024), --Se ingresa una indicacion al ultimo Proyecto que se ingreso.
   @estado char --En que estado va este proyecto
AS
BEGIN
    BEGIN TRY 
		Declare @id int, @idTp int
		set @id = (Select top 1 idProy from Proyecto order by idProy desc);
		insert into Anexo_Proyecto values (@indicación,GETDATE(),@estado,@id) ;
		set @idTp = @@IDENTITY;
		print @idTp;
		Return;
		COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1; 
    END CATCH
END;
Select * from Anexo_Proyecto
Drop 
Execute sp_UpdateAnexo_Proyecto 'esta' , 'A'


--Actualizar Proyecto del usuario

Create PROCEDURE sn_UpdateProyecto_Usuario
   @idUserd int,  --El id Del usuario que esta para que se registre con el Usuario
   @observacion varchar(1024), --Observaciones que se dieron al proyecto dado por el ususario
   @estado char --En que estado va este proyecto
AS
BEGIN
    BEGIN TRY 
		Declare @id int
		set @id = (Select top 1 idProy from Proyecto order by idProy desc);
		insert into Proyecto_Usuario values (@idUserd,@id,GETDATE(),@estado,@observacion) ;
		print 1;
		return;
		COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;