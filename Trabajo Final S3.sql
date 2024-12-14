--Crear una base de datos
create database inf;

--Utilizo la base de datos que cree
Use InnovaProject;

--Tablas Creadas acorde al informe dado
CREATE TABLE Usuario (
    idUser INT NOT NULL,
    nombre_user varchar(60) NOT NULL,
    AppPat_user varchar(60) NOT NULL,
    AppMat_user varchar(60),
    CONSTRAINT PK_Usuario PRIMARY KEY (idUser)
);

create table Acceso (
idAcceso INT  NOT NULL identity(1,1),
username varchar(30) NOT NULL,
llave varchar(30) NOT NULL,
idUser int NOT NULL, 
FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
constraint PK_Acceso primary key (idAcceso)
);

create table TipoProyecto (
idTP INT  NOT NULL identity(1,1),
nombreTP varchar(60) NOT NULL,
constraint PK_TipoProyecto primary key (idTP)
);

create table Proyecto (
idProy INT  NOT NULL identity(1,1),
nombreProy varchar(255) NOT NULL,
descProy varchar(1024) NOT NULL,
estado char(1)NOT NULL,
idTP int NOT NULL,
FOREIGN KEY (idTP) REFERENCES TipoProyecto(idTP),
constraint PK_Proyecto primary key (idProy)
);

create table Proyecto_Usuario (
idPU INT  NOT NULL identity(1,1),
idUser int NOT NULL,
idProy int NOT NULL,
Fecha dateTime NOT NULL,
estado char(1) NOT NULL,
Observacion varchar(1024),
FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
constraint PK_Proyecto_Usuario primary key (idPU)
);

create table Anexo_Proyecto(
idAP INT  NOT NULL identity(1,1),
Indicacion varchar(1024) NOT NULL,
Fecha dateTime NOT NULL,
estado char(1) NOT NULL,
idProy int NOT NULL,
FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
constraint PK_Anexo_Proyecto primary key (idAP)
);

create table Historico_Proyecto(
idHP INT NOT NULL identity(1,1),
periodo int NOT NULL,
cantidadPendientes int NOT NULL,
cantidadAprovados int NOT NULL,
cantidadRechazados int NOT NULL,
constraint PK_Historico_Proyecto primary key (idHP)
);

--  Probando tablas  --
--Usuario
Insert into Usuario Values (1,'Fabian','Barrenechea','Gutierrez');
Insert into Usuario Values (2,'Pablo','Quispe','Condori')
Insert into Usuario Values (3,'Pamela','Arce','')

--Acceso 
insert into Acceso values ('Fabian Gutierrez', 1201 , 1);
insert into Acceso values ('Pablo Quispe', 3521 , 2);
insert into Acceso values ('Pamela Arce', 2410 , 3);

--TipoProyecto 
insert into TipoProyecto values ('Tecnologicos');
insert into TipoProyecto values ('Sociales');
insert into TipoProyecto values ('Seguridad');

--Proyecto
insert into Proyecto values ('S.A. Avance','Sive para mejorar los proyectos que se utilizan dia a dia como la de plataforma RED','A',1);
insert into Proyecto values ('Paneles Solares','Es para darle un nuevo vistazo a la limpieza como facilitamiento de la limpieza en los paneles solares','A',1);
insert into Proyecto values ('Carriles Inteligentes','Es para informar de inconveniente de manera general y dar nuevos campos para el transporte u ofertas por los problemas dados','R',3);
--Proyecto_Usuario 
insert into Proyecto_Usuario values (1,1,'2021-11-26 01:29:03','A','Esta terminado con diversos problemas en su relacion con la especificacion orientada que tiene');
insert into Proyecto_Usuario values (2,2,'2021-09-13 06:39:17','R','Inconcluso y le falta solo que se ponga en marcha');
insert into Proyecto_Usuario values (3,3,'2021-09-23 06:04:11','R','Terminado y las fuentes a las cuales se le denomina no aprecian muy bien este tipo de reaccion');
--Anexo_Proyecto 
insert into Anexo_Proyecto values ('Esta para mejorar','2018-11-26 01:29:03','A',1);
insert into Anexo_Proyecto values ('Tiene una posible inconcruencia en la documentacion','2021-09-13 06:39:17','A',2);
insert into Anexo_Proyecto values ('Perfecto y posibles mejoras en los casos planteados','2021-09-23 06:04:11','R',3);
--Historico_Proyecto 
insert into Historico_Proyecto values (1,2,2,6);
insert into Historico_Proyecto values (3,4,3,3);
insert into Historico_Proyecto values (6,0,8,2);

--Usuario  --Acceso  --TipoProyecto  --Proyecto  --Proyecto_Usuario  --Anexo_Proyecto  --Historico_Proyecto
select * from Proyecto_Usuario;

-- Cree un procedimiento almacenado seguro que permita crear un usuario y crearle el
-- acceso con un username nombre +”.” + apellido paterno y llave 4321. Si hay un
-- error debe informarlo y no efectuar ninguna transacción. (3 puntos)

Create PROCEDURE sn_Crear_Userd
   @nrUser int,@nombre varchar(60), @AppPat varchar(60), @AppMat varchar(60)
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
        Insert into Usuario Values (@nrUser,@nombre,@AppPat,@AppMat);
		insert into Acceso values (@nombre +'.' + @AppPat,4321,@nrUser);
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Executar los datos de manera eficiente 
Exec sn_Crear_Userd 4,'Angel','Gutierrez',''

--Usuario  --Acceso  --TipoProyecto  --Proyecto  --Proyecto_Usuario  --Anexo_Proyecto  --Historico_Proyecto
select * from Usuario;
select * from Acceso;


--Cree un procedimiento almacenado seguro que permita agregar un proyecto e
--incremente la columna cantidadPendientes de la tabla Historico_Proyecto. Si hay un
--error debe informarlo y no efectuar ninguna transacción. (4,5 puntos)

Create PROCEDURE sn_Agregar_proyect
   @nombreProyecto varchar(255),@DescpProyect varchar(1024),@estado char, @IdTipoProyecto int
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		declare @posicion int
		set @posicion = (SELECT TOP 1 idHP FROM Historico_Proyecto order by idHP desc);
		if (@estado = 'A') or (@estado = 'R') or (@estado = 'P')
		begin
		insert into Proyecto values (@nombreProyecto,@DescpProyect,@estado,@IdTipoProyecto);
		update Historico_Proyecto  SET cantidadPendientes = cantidadPendientes + 1 where idHP = @posicion;
		end;
		else
		begin
        COMMIT TRANSACTION;  
		end;
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;
--Ejecutar la
Exec sn_Agregar_proyect 'Angel Pruebas','Testeo de la pagina', 'P', 1

--Usuario  --Acceso  --TipoProyecto  --Proyecto  --Proyecto_Usuario  --Anexo_Proyecto  --Historico_Proyecto
select * from Proyecto;
select * from Historico_Proyecto;


-- Cree un procedimiento almacenado seguro que permita actualizar el estado de un
-- proyecto (Aprobado o Rechazado) e incremente la columna cantidadAprobados o
-- cantidadRechazados según corresponda. Si hay un error debe informarlo y no
-- efectuar ninguna transacción. Si hay un error debe informarlo y no efectuar ninguna
-- transacción. (6 puntos)

Create PROCEDURE sn_Actualizar_estado
   @IDProyecto int,@IngreseEstado char
AS
BEGIN
    BEGIN TRY 
		declare @posicion int
		declare @Resultado char
		declare @Cantidad int
        BEGIN TRANSACTION;
		set @Cantidad = (Select top 1 idProy from Proyecto order by idProy desc)
		set @posicion = (Select top 1 idHP from Historico_Proyecto order by idHP desc);
		
		if @Cantidad < @IDProyecto
			begin
            RETURN; 
			end
		update Proyecto  SET estado = @IngreseEstado where idProy = @IDProyecto;
		set @Resultado = (select estado from Proyecto where idProy = @IDProyecto);
		if @Resultado = 'A'
		begin
		update Historico_Proyecto  SET cantidadRechazados = cantidadRechazados + 1 where idHP = @posicion;
		end;
		else if @Resultado = 'R'
		begin
		update Historico_Proyecto  SET cantidadAprovados = cantidadAprovados + 1 where idHP = @posicion;
		end;
		else 
		begin
            RETURN; 
		end;
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Ejecutar la
Exec sn_Actualizar_estado 4,'P'


--Usuario  --Acceso  --TipoProyecto  --Proyecto  --Proyecto_Usuario  --Anexo_Proyecto  --Historico_Proyecto
select * from Proyecto ;
select * from Historico_Proyecto ;

--Cree un procedimiento almacenado seguro que permita mostrar por periodo (año -
--parametro) por tipo de proyecto la cantidad de aprobados, pendientes y rechazados.
--Si hay un error debe informarlo y no efectuar ninguna transacción. (9 puntos)

Create PROCEDURE sn_almecenado
   @IngreseAño int
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION;
		 SELECT 
				isnull(tp.nombreTP, '   Total') 
			as 
				"Tipo Proyecto",
			sum(
				case
					when 
						pr.estado = 'P'		
						then 1 else 0 
					end
				) 
			as 
				"Pendientes",

			sum(
				case
					when 
						pr.estado = 'R' 
						then 1 else 0 
					end
				)
			as 
				"Rechazados",

			SUM(
				case 
					when 
					pr.estado = 'A' 
					then 1 else 0 
				end
				) 
			as 
				"Aprobados",

			COUNT(*) as "Total"
		FROM 
			TipoProyecto tp,
			Proyecto pr,
			Proyecto_Usuario Pu 
		WHERE 
			YEAR(pu.Fecha) = @IngreseAño and
			pr.idProy = Pu.idProy and 
			tp.idTP = pr.idTP
		GROUP BY 
			ROLLUP(tp.nombreTP);
		COMMIT TRANSACTION;  
		END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;  
        PRINT -1;  
    END CATCH
END;

--Ejecutar la
Exec sn_almecenado 2021
