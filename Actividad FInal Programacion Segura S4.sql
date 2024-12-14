
--Tablas Creadas acorde al informe dado
CREATE TABLE TipoUsuario(
    idTU INT NOT NULL identity(1,1), --idTU carácter numérico entero único generado automáticamente
    nombreTU varchar(60) NOT NULL, --carácter de largo variable de 60
    CONSTRAINT PK_TipoUsuario PRIMARY KEY (idTU)
);

CREATE TABLE Usuario(
    idUser INT NOT NULL, -- carácter de largo variable de 60
    nombre varchar(60) NOT NULL, --carácter de largo variable de 60
    AppPat varchar(60) NOT NULL, --carácter de largo variable de 60
    AppMat varchar(60), --carácter de largo variable de 60
    idTU INT NOT NULL, --carácter numérico entero
	FOREIGN KEY (idTU) REFERENCES TipoUsuario(idTU),
    CONSTRAINT PK_Usuario PRIMARY KEY (idUser)
);

CREATE TABLE Acceso(
    idAcceso INT NOT NULL identity(1,1), -- carácter numérico entero único generado automáticamente
    username varchar(30) NOT NULL, -- carácter de largo variable de 30
    llave varchar(30) NOT NULL, --carácter de largo variable de 60
    idUser INT NOT NULL, --carácter numérico entero
	FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
    CONSTRAINT PK_Acceso PRIMARY KEY (idAcceso)
);
select * from Proyecto;
Execute sp_ALL_PROYECTOS
select idUser from Acceso where username = 'carla.fenandez' and llave= '4321'

CREATE TABLE TipoProyecto(
    idTP INT NOT NULL identity(1,1), -- carácter numérico entero único generado automáticamente
    nombreTP varchar(60) NOT NULL, -- carácter de largo variable de 60
    CONSTRAINT PK_TipoProyecto PRIMARY KEY (idTP)
);

CREATE TABLE Proyecto(
    idProy INT NOT NULL identity(1,1), -- carácter numérico entero único generado automáticamente
    nombreProy varchar(255) NOT NULL, -- carácter de largo variable de 255
	descProy varchar(1024) NOT NULL, -- carácter de largo variable de 1024
    idTP INT NOT NULL, --carácter numérico entero
	FOREIGN KEY (idTP) REFERENCES TipoProyecto(idTP),
    CONSTRAINT PK_Proyecto PRIMARY KEY (idProy)
);

CREATE TABLE Proyecto_Usuario(
    idPU INT NOT NULL identity(1,1), -- carácter numérico entero único generado automáticamente
    idUser INT NOT NULL, --carácter numérico entero
    idProy INT NOT NULL, --carácter numérico entero
    fecha DATETIME NOT NULL, --carácter de formato fecha y hora
	estado char(1) NOT NULL, -- carácter de largo 1
	observacion varchar(1024), -- carácter de largo variable de 1024
	FOREIGN KEY (idUser) REFERENCES Usuario(idUser),
	FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
    CONSTRAINT PK_Proyecto_Usuario PRIMARY KEY (idPU)
);

CREATE TABLE Anexo_Proyecto(
    idAP INT NOT NULL identity(1,1), -- carácter numérico entero único generado automáticamente
	indicación varchar(1024) NOT NULL, -- carácter de largo variable de 1024
    fecha DATETIME NOT NULL, --carácter de formato fecha y hora
	estado char(1) NOT NULL, -- carácter de largo 1
    idProy INT NOT NULL, --carácter numérico entero
	FOREIGN KEY (idProy) REFERENCES Proyecto(idProy),
    CONSTRAINT PK_Anexo_Proyecto PRIMARY KEY (idAP)
);