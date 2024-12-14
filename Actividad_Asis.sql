/*Tipo de Colegio*/
create table Comuna(
id_Comuna int not null,
nombre_C char(60),
Pais Char(20),
constraint PK_Comuna primary key (id_Comuna)
);
Create table Comvenio_IE(
id_Comvenio_IE int not null,
nombre_Emp_IE char(20)not null,
Tipo_Comvenio Boolean not null,
Ubicacion_Pais char(60),
constraint PK_Comvenio_IE primary key (id_Comvenio_IE)
);
create table colegio(
id_Colegio int not null,
nombreC char(50) not null,
Foleo char(30) not null,
id_C int not null,
id_Comvenio_IE int not null,
Constraint PK_colegio primary key (id_Colegio),
CONSTRAINT FK_colegio FOREIGN KEY(id_Comvenio_IE) REFERENCES Comvenio_IE(id_Comvenio_IE),
CONSTRAINT FK_colegio FOREIGN KEY(id_C) REFERENCES Comuna(id_Comuna)
);
/*Curso*/
Create table Curso(
ID_Profesor int not null,
id_Curso int not null,
Cantidad_A int not null,
Año_Cursado char(20) not null,
Seccion_AC char(20) not null,
Ubicacion char(30),
Constraint PK_Curso primary key (id_Curso),
CONSTRAINT FK_Curso FOREIGN KEY(ID_Profesor) REFERENCES Profesor(ID_Profesor)
);
/*Tipo de Colegio*/
Create table Profesor(
ID_Profesor int not null,
nombre char(20) not null,
apellido_Pat char(20) not null,
apellido_Mat char(20),
especialidad char(20) not null,
Años_Esp int,
Constraint PK_Profesor primary key (ID_Profesor),
);
Create table Colegio_Profesor(
ID_CP int not null,
ID_Profesor int not null,
id_C int not null,
fecha dateTime,
Constraint PK_Colegio_Profesor primary key (ID_CP),
CONSTRAINT FK_Colegio_Profesor FOREIGN KEY(ID_Profesor) REFERENCES Profesor(ID_Profesor),
CONSTRAINT FK_Colegio_Profesor FOREIGN KEY(id_C) REFERENCES colegio(id_Colegio)
);
/*Tipo de SupperVisor*/
Create table SupperVisor(
ID_SupperVisor int not null,
id_Colegio int not null,
nombre char(20) not null,
apellidoPat char(20)not null,
apellidoMat char(20)not null,
Constraint PK_SupperVisor primary key (ID_SupperVisor),
CONSTRAINT FK_SupperVisor FOREIGN KEY(id_Colegio) REFERENCES Colegio(id_Colegio)
);
/*Tipo de Nota Asistencia*/
Create table Asistencia(
ID_SupperVisor int not null,
id_Asistencia int not null,
Firma_S char(20) not null,
Fecha_Cr_A DateTime not null,
Semana_R_A date not null,
Constraint PK_Asistencia primary key (id_Asistencia),
CONSTRAINT FK_Asistencia FOREIGN KEY(ID_SupperVisor) REFERENCES SupperVisor(ID_SupperVisor)
);
Create table Observaciones(
id_O int not null,
Descipcion_O char(30) not null,
Cantidad_Faltas int not null,
Cantidad_Asistencias int not null,
Fecha_O date not null,
id_Asistencia int not null,
CONSTRAINT PK_Observaciones  primary key(id_O),
CONSTRAINT FK_Observaciones FOREIGN KEY(id_Asistencia) REFERENCES Asistencia(id_Asistencia)
);
Create table Alumno(
Numero_Matricula int not null,
Nombre_A char(30) not null,
ApellidoPAt_A char(30) not null,
ApellidoMAt_A char(30),
Fecha_I_A date ,
id_Asistencia int not null,
id_Curso int not null,
CONSTRAINT PK_Alumno  primary key(Numero_Matricula),
CONSTRAINT FK_Alumno FOREIGN KEY(id_Curso) REFERENCES Curso(id_Curso),
CONSTRAINT FK_Alumno FOREIGN KEY(id_Asistencia) REFERENCES Asistencia(id_Asistencia)
);