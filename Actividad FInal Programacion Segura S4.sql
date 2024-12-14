
--Tablas Creadas acorde al informe dado
CREATE TABLE TipoUsuario(
    idTU INT NOT NULL identity(1,1), --idTU car�cter num�rico entero �nico generado autom�ticamente
    nombreTU varchar(60) NOT NULL, --car�cter de largo variable de 60
    CONSTRAINT PK_TipoUsuario PRIMARY KEY (idTU)
);

CREATE TABLE Usuario(
    idUser INT NOT NULL, -- car�cter de largo variable de 60
    nombre varchar(60) NOT NULL, --car�cter de largo variable de 60
    AppPat varchar(60) NOT NULL, --car�cter de largo variable de 60
    AppMat varchar(60), --car�cter de largo variable de 60
    idTU INT NOT NULL, --car�cter num�rico entero
	FOREIGN KEY (idTU) REFERENCES TipoUsuario(idTU),
    CONSTRAINT PK_Usuario PRIMARY KEY (idUser)
);

CREATE TABLE Acceso(
    idAcceso INT NOT NULL identity(1,1), -- car�cter num�rico entero �nico generado autom�ticamente
    username varchar(30) NOT NULL, -- car�cter de largo variable de 30
    llave varchar(30) NOT NULL, --car�cter de largo variable de 60
    idUser INT NOT NULL, --car�cter num�rico entero
	FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
    CONSTRAINT PK_Acceso PRIMARY KEY (idAcceso)
);
select * from Proyecto;
Execute sp_ALL_PROYECTOS
select idUser from Acceso where username = 'carla.fenandez' and llave= '4321'

CREATE TABLE TipoProyecto(
    idTP INT NOT NULL identity(1,1), -- car�cter num�rico entero �nico generado autom�ticamente
    nombreTP varchar(60) NOT NULL, -- car�cter de largo variable de 60
    CONSTRAINT PK_TipoProyecto PRIMARY KEY (idTP)
);

CREATE TABLE Proyecto(
    idProy INT NOT NULL identity(1,1), -- car�cter num�rico entero �nico generado autom�ticamente
    nombreProy varchar(255) NOT NULL, -- car�cter de largo variable de 255
	descProy varchar(1024) NOT NULL, -- car�cter de largo variable de 1024
    idTP INT NOT NULL, --car�cter num�rico entero
	FOREIGN KEY (idTP) REFERENCES TipoProyecto(idTP),
    CONSTRAINT PK_Proyecto PRIMARY KEY (idProy)
);

CREATE TABLE Proyecto_Usuario(
    idPU INT NOT NULL identity(1,1), -- car�cter num�rico entero �nico generado autom�ticamente
    idUser INT NOT NULL, --car�cter num�rico entero
    idProy INT NOT NULL, --car�cter num�rico entero
    fecha DATETIME NOT NULL, --car�cter de formato fecha y hora
	estado char(1) NOT NULL, -- car�cter de largo 1
	observacion varchar(1024), -- car�cter de largo variable de 1024
	FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
	FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
    CONSTRAINT PK_Proyecto_Usuario PRIMARY KEY (idPU)
);

CREATE TABLE Anexo_Proyecto(
    idAP INT NOT NULL identity(1,1), -- car�cter num�rico entero �nico generado autom�ticamente
	indicaci�n varchar(1024) NOT NULL, -- car�cter de largo variable de 1024
    fecha DATETIME NOT NULL, --car�cter de formato fecha y hora
	estado char(1) NOT NULL, -- car�cter de largo 1
    idProy INT NOT NULL, --car�cter num�rico entero
	FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
    CONSTRAINT PK_Anexo_Proyecto PRIMARY KEY (idAP)
);