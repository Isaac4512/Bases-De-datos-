--1-Mostrar los datos de todas las boletas
select * from BOLETA
--2- Mostar los datos de las boletas del año 2021
select * from BOLETA where Year(fecha) = 2021;
select * from BOLETA where DatePart(year,fecha) = 2021;

--3 mostrar la cantidad de boletas del año 2021
sELECT count(numero) as "cantidad de Boletas" from BOLETA where Year(fecha) = 2011;
--4 Mostrar los datos de las boletas del año 2021 ordenadas por mes en forma ascendente
select * from BOLETA where Year(fecha) = 2021 Order by MONTH(Fecha)ASC;
--5 Mostrar las ventas del 2do trimestre del 2021
select * from BOLETA where Datepart(q,fecha) = 2 and Year(fecha) =2021 ;

-- 6 Mostrar las ventas del 1er semestre del 2021
	--Primera Forma
	select * from BOLETA where MONTH(fecha) between 1 and 6 and Year(fecha) =2021 ;
	--Segunda Forma
	select * from BOLETA where Datepart(q,fecha) in(1,2) and Year(fecha) =2021 ;

--7. Mostrar las ventas del 4to bimestre del 2021
-- 1F
select * from BOLETA where MONTH(fecha) between 7 and 8 and Year(fecha) =2021 ;
-- 2F
select * from BOLETA where MONTH(fecha)in(7,8) and Year(fecha) =2021 ;

--8. Mostrar los datos de las boletas de los tres años anteriores al actual
Select * from BOLETA where YEAR(fecha) <= YEAR(GETDATE()) - 3 ; 

--9. Mostrar las ventas del 2do trimestre del 2021
Select * from BOLETA where month(fecha) >= 4 And MONTH(fecha) <= 6 and YEAR(fecha) = 2021;  

--10. Mostrar los montos totales de las boletas por trimestre del 2021 en forma ascendente.
Select 
	DATEPART(q,fecha) 
as 
	Trimestre,SUM(monto) 
as 
	"Monto Total" 
from 
	BOLETA 
where 
	YEAR(fecha) = 2021 
group by 
	DATEPART(q,fecha)
order by 
	Trimestre  asc; 

-- 11. Mostrar las boletas del año 2021 cuyo monto este sobre el monto promedio del año 2021
Select 
	monto 
from 
	BOLETA 
where 
	YEAR(fecha) = 2021 
and
	monto > (
				--El AVG es para tener el Promedio
				select AVG(monto) 
				from Boleta 
				where year(fecha) = 2021);

-- 12. Mostrar las boletas emitidas entre las 8 y 12 a.m. del mes marzo del 2021
	select * from BOLETA where datepart(hh,fecha) between 8 and 12
	and MONTH(fecha) = 3 and Year(fecha) =2021;


-- 13. Mostrar la cantidad de las boletas emitidas en la mañana (0 a 8 a.m. inclusive), medio día (las 8 y 16 p.m. inclusive), tarde (16 p.m. a 0 .a.m. inclusive) del mes diciembre del 2021
--UNION
select 'Mañana' as  Etapa,count(numero) as "Cantidad Boletas" from BOLETA where datepart(hh,fecha) between 0 and 8
	and MONTH(fecha) = 12 and Year(fecha) =2021
union
select 'Medio Dia'as  Etapa,count(numero) as "Cantidad Boletas" from BOLETA where datepart(hh,fecha) between 9 and 16
	and MONTH(fecha) = 12 and Year(fecha) =2021
union 
select 'Noche'as  Etapa ,count(numero) as "Cantidad Boletas" from BOLETA where datepart(hh,fecha) between 17 and 23
	and MONTH(fecha) = 12 and Year(fecha) =2021


-- 14. Mostrar la cantidad de boletas emitidas el 21 de abril del 2022 las primeras 500 milésimas de segundo.
select count(numero) as "Cantidad Boletas" from BOLETA where datepart(ms,fecha)<= 500 and day(fecha) = 21
	and MONTH(fecha) = 4 and Year(fecha) =2021;

-- 15. Mostrar la cantidad de productos vendidos por producto (nombre) en marzo del 2022 ordenados de mayor a menor.
select p.nombreProd as Producto,SUM(db.cantidad) as Cantidad 
from BOLETA b,DETALLE_BOLETA db,PRODUCTO p where
	MONTH(b.fecha) = 3 and Year(b.fecha) =2022 and b.numero = db.numero and  db.idProd = p.idProd 
	group by
		p.nombreProd
	order by
		sum(db.cantidad) desc;

-- 16. Mostrar los productos vendidos marzo del 2022 y que no vendieron en abril del 2022 ordenados por nombre del producto.
select 
	Distinct --Este valua solo un dato
	p.nombreProd as Producto
from 
	Boleta b,DETALLE_BOLETA db,PRODUCTO p
where
	MONTH(b.fecha) = 3 and Year(b.fecha) =2022
	and b.numero = db.numero and  
	db.idProd = p.idProd 
Except
select 
	Distinct --Este valua solo un dato
	p.nombreProd as Producto
from 
	Boleta b,Detalle_boleta db,PRODUCTO p
where
	MONTH(b.fecha) = 4 and Year(b.fecha) =2022
	and b.numero = db.numero and  
	db.idProd = p.idProd 
-- 17. Mostrar el IVA a pagar por trimestre el año 2023.
Select 
	DATEPART(q,fecha) as Trimestre, sum(monto / 119)* 19 as "Monto IVa"
from 
	Boleta 
where 
	YEAR(fecha) = 2021 
group by 
	DATEPART(q,fecha)
order by 
	Trimestre  asc; 

-- 18. Mostrar la cantidad total de productos por cuatrimestre del año 2021.
select 
	'1'as "Se encuentra en el cuatrimestre",SUM(db.cantidad) as Cantidad 
from BOLETA b,DETALLE_BOLETA db,PRODUCTO p where
	datepart(M,fecha) between 1  and 4 and Year(b.fecha) =2021 and b.numero = db.numero and  db.idProd = p.idProd 
union
select 
	'2',SUM(db.cantidad)
from BOLETA b,DETALLE_BOLETA db,PRODUCTO p where
	datepart(M,fecha) between 5  and 8 and Year(b.fecha) =2021 and b.numero = db.numero and  db.idProd = p.idProd 
union
select 
	'3',SUM(db.cantidad)
from BOLETA b,DETALLE_BOLETA db,PRODUCTO p where
	datepart(M,fecha) between 9  and 12 and Year(b.fecha) =2021 and b.numero = db.numero and  db.idProd = p.idProd 

-- 19. Cree una función que dada una fecha entregue el cuatrimestre
--Crear una funcion para utilizarse
create function cuatrimestre (@fecha date)
returns int 
as 
begin
	declare @nroCuatrimestre int
	if month(@fecha) >= 1 and  month(@fecha) <=4
	begin
		set @nroCuatrimestre = 1;
	end;
	else
	begin 
		if month(@fecha) >= 5 and  month(@fecha) <=8
		begin
			set @nroCuatrimestre =2;
		end;
		else
		begin
			set @nroCuatrimestre = 3;
		end;
	end;
	return @nroCuatrimestre;
end;

--llamado a la funcion con la fecha actual
select dbo.cuatrimestre(Getdate());

-- 20. Ídem 18 utilizando la función 19.

select 
	dbo.cuatrimestre(fecha) as "Nro Cuatrimestre", sum(db.cantidad) as Cantidad
from 
	BOLETA b, DETALLE_BOLETA db,PRODUCTO p 
where
	Year(b.fecha) = 2021 and
	b.numero = db.numero and
	db.idProd = p.idProd
group by
--Utilizar el grupo para que este mismo sea 
	dbo.cuatrimestre(fecha)
order by
	"Nro Cuatrimestre" asc;