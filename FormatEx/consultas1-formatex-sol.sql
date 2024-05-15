USE FormatExBD;

-- Consulta todos los alumnos de la plataforma ordenados por nombre
select * from alumno order by nombre;

-- Consulta todos los procesores de la plataforma ordenados por DNI
select * from profesor order by DNI;

-- Consulta todos los ciclos existentes ordenados por familia descendente
select * from ciclo order by cod_familia desc;


-- Consulta todos los ciclos existentes cuya sigla empiece por D
select * from ciclo where sigla like 'D%';

/* Selecciona todos los profesores del departamento de Informática. */
-- Con join si puedo traer el nombre de departamento
select p.* , d.nombre
from profesor p
join departamento d on p.cod_dpto = d.cod_dpto
where d.nombre = 'Informática';

-- Con subconsulta en el where en este caso no puedo traer el nombre del departamento
select p.*
from profesor p
where p.cod_dpto = (Select d.cod_dpto from departamento d where d.nombre = 'Informática');
    
-- Con subconsulta en el where en este caso no puedo traer el nombre del departamento
select p.* 
from profesor p
where exists ( Select d.cod_dpto 
					from departamento d 
                    where p.cod_dpto = d.cod_dpto and d.nombre = 'Informática' );
                    
-- Con subconsulta en el from-join  aquí si se puede traer el nombre
select p.*, aux.nombre
from (Select d.cod_dpto, d.nombre from departamento d where d.nombre = 'Informática') aux
join profesor p ON p.cod_dpto = aux.cod_dpto;
    

select * 
	from profesor
    where cod_dpto = (Select cod_dpto from departamento where nombre = 'Informática');

select * 
	from profesor p
    where exists (Select cod_dpto 
					from departamento d 
                    where p.cod_dpto = d.cod_dpto and 
                    d.nombre = 'Informática');
                    
select * 
	from profesor p
    join (Select cod_dpto 
		  from departamento d 
          where d.nombre = 'Informática'
          ) aux on p.cod_dpto = aux.cod_dpto; 

-- Muestra el nombre completo de los profesores que no tienen un segundo apellido.
select concat_ws(' ', nombre, prApellido, sgApellido)
from profesor 
where sgApellido is null;

-- Lista los módulos impartidos en el ciclo DAM.
select m.*
from modulo m
 join ciclo c on m.cod_ciclo = c.cod_ciclo
 where  c.sigla = 'DAM';
 
 select * 
 from modulo
 where cod_ciclo = (
		 select cod_ciclo
		 from ciclo
		 where sigla = 'DAM');

 select *
 from modulo m
 where exists (
		select cod_ciclo
		 from ciclo
		 where sigla = 'DAM' and m.cod_ciclo = cod_ciclo
 );


select modulo.*, ciclo_dam.nombre, ciclo_dam.cod_familia
from modulo 
	join (Select cod_ciclo, nombre, cod_familia
				from ciclo 
				where sigla = 'DAM'
		 ) ciclo_dam ON modulo.cod_ciclo = ciclo_dam.cod_ciclo;


-- Encuentra los profesores que no están asignados a ningún departamento.
select * from profesor where cod_dpto is null;

-- Muestra los nombres de los profesores junto con el nombre de su departamento.
select  concat_ws(' ', p.nombre, p.prApellido, p.sgApellido), d.nombre as nombre_dpto
from profesor p 
join departamento d on p.cod_dpto = d.cod_dpto;



-- Cuenta el número de profesores por departamento. Debe aparecer el nombre del departamento y total de profesores.
select d.nombre, count(p.dni) total_profes
from profesor p
join departamento d on p.cod_dpto = d.cod_dpto
group by d.cod_dpto;


-- De la consulta anterior, solo obten el que más numero de profesores tienen.
select d.nombre, count(p.dni) total_profes
from profesor p
join departamento d on p.cod_dpto = d.cod_dpto
group by d.cod_dpto
order by total_profes desc
limit 1;



-- Encuentra el nombre y apellidos de los profesores que imparten módulos en el primer curso.
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
join modulo m on cm.cod_modulo = m.cod_modulo
where m.curso = 1;

select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
where exists (
			select c.dni_profesor
			from contrato c 
				join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
				join modulo m on cm.cod_modulo = m.cod_modulo
				where p.dni = c.dni_profesor and m.curso = 1);


select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
where p.dni in (
			select c.dni_profesor
			from contrato c 
				join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
				join modulo m on cm.cod_modulo = m.cod_modulo
				where m.curso = 1
			);
                

-- Lista todos los módulos bilingües.
select *
from modulo
where bilingue = 'S';

-- Muestra los módulos que tienen más de 200 horas.
select *
from modulo
where numhoras > 200;


-- Encuentra el nombre y apellidos de los profesores que no tienen asignado un correo electrónico.
select concat_ws(' ', nombre, prApellido, sgApellido)
from profesor
where mail is null;

-- Muestra el nombre del ciclo y el nombre de la familia correspondiente.
select c.nombre ciclo, f.nombre familia
from ciclo c
join familia f on c.cod_familia = f.cod_familia;


-- Lista los nombres de los módulos y las notas obtenidas por los alumnos.
select m.nombre, c.nota
from modulo m
join calificacion c on c.cod_modulo = m.cod_modulo;


-- Lista los nombres de los módulos, el nombre del alumno y las notas.
select m.nombre nombre_comdulo, a.nombre, c.nota
from modulo m
join calificacion c on c.cod_modulo = m.cod_modulo
join matricula mt on c.matricula = mt.matricula
join alumno a on mt.dni_alumno = a.dni;

-- Encuentra el nombre del profesor que imparte el módulo con el código 3.
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
where cm.cod_modulo = 3;


-- Muestra el nombre del profesor director de cada departamento.
select concat_ws(' ', p.nombre, p.prApellido, p.sgApellido), d.nombre
from profesor p 
join departamento d on p.dni = d.dni_director;


-- Lista los nombres de los alumnos que nacieron después del año 2000.
select nombre
from alumno
where year(fecha_nacimiento) > 2000;



-- Cuenta el numero de módulos impartidos por cada profesor.
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido), count(cm.cod_modulo)
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
group by p.dni;



-- Este no estaba en el enunciado: 
-- Cuenta el numero de módulos impartidos por cada profesor, ciclo y curso. 
-- Debe de aparecer el curso, nombre del ciclo, nombre completo del profe y el total de modulos
select m.curso, cl.nombre, concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_completo, count(cm.cod_modulo) total_modulos
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
join modulo m on cm.cod_modulo = m.cod_modulo
join ciclo cl on cl.cod_ciclo = m.cod_ciclo
group by p.dni, cl.cod_ciclo, m.curso;


select m.curso, cl.nombre, concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_completo, m.nombre
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
join modulo m on cm.cod_modulo = m.cod_modulo
join ciclo cl on cl.cod_ciclo = m.cod_ciclo;


-- Muestra el número total de horas de cada ciclo. Debe mostrar el ciclo y las horas totales.
select c.nombre, sum(m.numhoras)
from ciclo c
join modulo m on c.cod_ciclo = m.cod_ciclo
group by m.cod_ciclo;

-- ESTE NO ESTABA EN EL ENUNCIADO, 
-- Muestra el número total de horas de cada ciclo y curso.
-- Debe mostrar el ciclo, curso y las horas totales.
select c.nombre, m.curso, sum(m.numhoras)
from ciclo c
join modulo m on c.cod_ciclo = m.cod_ciclo
group by m.cod_ciclo, m.curso;

-- ESTE NO ESTABA EN EL ENUNCIADO, Muestra el número total de horas de cada ciclo y curso. Debe mostrar el ciclo, curso y las "horas totales de año" de "horas totales por ciclo"
Select  totalPorGrupo.nombre, totalPorGrupo.curso, concat (totalPorGrupo.sum1, ' de ', totalDeTotales.sum2)
from 
	(select c1.cod_ciclo, sum(m1.numhoras) sum2
    from ciclo c1 
    join modulo m1 on c1.cod_ciclo = m1.cod_ciclo 
    group by m1.cod_ciclo) totalDeTotales
join (select c.cod_ciclo, c.nombre, m.curso, sum(m.numhoras) sum1
			from ciclo c
			join modulo m on c.cod_ciclo = m.cod_ciclo
			group by m.cod_ciclo, m.curso) totalPorGrupo
where totalDeTotales.cod_ciclo = totalPorGrupo.cod_ciclo;


-- Lista los módulos ordenados por nombre.
select * from modulo order by nombre;


-- Encuentra el nombre y apellidos de los profesores que imparten módulos en el segundo curso.
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
join contrato c on p.dni = c.dni_profesor
join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
join modulo m on cm.cod_modulo = m.cod_modulo
where m.curso = 2;


-- Muestra el número de módulos impartidos en cada ciclo. Debe aparecer el ciclo y el total de módulos.
select c.nombre, count(m.cod_ciclo)
from ciclo c
join modulo m on c.cod_ciclo = m.cod_ciclo
group by m.cod_ciclo;

-- ESTE NO ESTABA Muestra el número de módulos impartidos en cada ciclo y curso. Debe aparecer el ciclo, curso y el total de módulos.
select c.nombre, m.curso, count(m.cod_ciclo)
from ciclo c
join modulo m on c.cod_ciclo = m.cod_ciclo
group by m.cod_ciclo, m.curso;


-- Encuentra los alumnos que la ultima titulacion sea 'CFGM'.
select *
from alumno
where ultima_titulacion = 'CFGM';

-- Encuentra los alumnos que la ultima titulacion sea 'CFGM' o 'BACH'. Ordena por ultima titulacion
select *
from alumno
where ultima_titulacion in ('CFGM', 'BACH')
order by ultima_titulacion;


-- Cuenta el numero de alumnos existentes por cada ultima titulacion.
select ultima_titulacion, count(dni) total_alumno
from alumno
group by ultima_titulacion;

/* ESTE ENUNCIADO NO ESTABA Saca los datos de los alumnos que tenga como tilulacion aquella que el número total de alumno en dicha titulacion sea mayor o igual a 4. Nombre, ape1, ape2 y titulacion */
select a.*
from alumno a
where a.ultima_titulacion in (select ultima_titulacion
								from alumno
								group by ultima_titulacion
								having count(dni) >= 4);


/* Lista los módulos que tienen una nota superior a 8.*/

-- Subconsulta en el where
select m.*
from modulo m
where m.cod_modulo in (select distinct cod_modulo from calificacion where nota > 8);

-- con join 
select m.*
from modulo m
join calificacion c on c.cod_modulo = m.cod_modulo 
where c.nota > 8;

-- Con subconsulta exists y correlacionada
select m.*
from modulo m
where exists (select distinct cod_modulo from calificacion where nota > 8 and cod_modulo = m.cod_modulo);



-- Muestra el nombre y apellidos de los profesores que tienen un correo electrónico.
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
where p.mail is not null;


/* Lista los nombres de los profesores que imparten módulos en el ciclo DAM. */

-- Con joins
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido)
from profesor p 
	join contrato c on p.dni = c.dni_profesor
	join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
	join modulo m on cm.cod_modulo = m.cod_modulo
	join ciclo cl on m.cod_ciclo = cl.cod_ciclo
	where cl.sigla = 'DAM';

-- Con subconsulta en el where y exists
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape_profe_dam
from profesor p 
where exists (select c.dni_profesor from contrato c
				join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
				join modulo m on cm.cod_modulo = m.cod_modulo
				join ciclo cl on m.cod_ciclo = cl.cod_ciclo
				where cl.sigla = 'DAM'
                and p.dni = c.dni_profesor);

-- Con subconsulta en el where con in               
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape_profe_dam
from profesor p 
where p.dni in (select c.dni_profesor from contrato c
				join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
				join modulo m on cm.cod_modulo = m.cod_modulo
				join ciclo cl on m.cod_ciclo = cl.cod_ciclo
				where cl.sigla = 'DAM');

                
-- Con subconsulta en el from-join               
select distinct concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape_profe_dam
from profesor p      
join   (select c.dni_profesor from contrato c
				join contrato_modulo cm on cm.cod_contrato = c.cod_contrato
				join modulo m on cm.cod_modulo = m.cod_modulo
				join ciclo cl on m.cod_ciclo = cl.cod_ciclo
				where cl.sigla = 'DAM') profes_dam
where p.dni = profes_dam.dni_profesor;




/* Muestra el nombre completo del profesor que tiene el contrato con el código 5. */
-- Con join
select concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape
from profesor p
join contrato c on c.dni_profesor = p.dni
where c.cod_contrato = 5;

-- Con subselect en el where 
select concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape
from profesor p
where p.dni = (select dni_profesor from contrato where cod_contrato = 5);

-- Con subselect en el where correlacionada
select concat_ws(' ', p.nombre, p.prApellido, p.sgApellido) nombre_ape
from profesor p
where exists (select dni_profesor 
				from contrato 
				where cod_contrato = 5 
				and p.dni = dni_profesor);


-- Lista los módulos y las notas obtenidas por los alumnos en orden descendente de nota.
select m.nombre,  c.nota
from modulo m
join calificacion c on c.cod_modulo = m.cod_modulo
order by nota desc;


-- Calcula la media de todas las calificaciones existentes.
select round(avg(nota),2) nota_media_total
from calificacion;

-- Calcula la media por módulo
select cod_modulo, round(avg(nota),2) nota_media_modulo
from calificacion
group by cod_modulo;

-- Calcula la media por matricula.
select matricula, round(avg(nota),2) nota_media_matricula
from calificacion
group by matricula;