/* 
    PRACTICAR CONSULTAS EXTERNAS, LAS OUTER JOIN 
    Lee el tema primero para que lo entiendas: 
    https://sites.google.com/view/dam-basesdedatos/5-sqldml-consultas/consultas-en-varias-tablas#h.ltrbhp5wz9yx 

    Pero cuidado: 
        ¡No todas son outer join (left join, right join o full join) hay también inner join (join)
*/


/*
Encuentra todas las personas que han adoptado mascotas y muestra también aquellas que no han adoptado ninguna mascota.
Muestra el nombre completo de la persona, id del animal y la fecha de adopción.
Ordena por nombre de la persona.
 */


/*
Muestra el nombre completo de la persona y la última fecha de adopción tanto de las personas que si han adoptado como las que no.
Ordena por nombre de la persona.
 */


/*
Muestra el nombre todas las mascotas que han sido adoptadas, incluyendo aquellas que aún no han sido adoptadas. 
Además del nombre, muestra la fecha de adopción.
Ordena por nombre del animal.
 */


/*
Muestra el nombre completo de la persona, el nombre de la mascota y cuando la adoptó. 
Tanto para las personas que han adoptado como las que no. 
Ordena por el nombre de la persona.
 */


/*
Muestra el nombre completo de la persona, el nombre de la mascota y cuando la adoptó muestra también las mascotas que aún no han sido adoptadas. 
Ordena por el nombre de la persona.
 */


/*
Muestra nombre completo de la persona, el nombre de la mascota y cuando la adoptó, 
excluyendo aquellas mascotas que aún no han sido adoptadas.
 */


/* 
Muestra nombre completo de la persona, el nombre de la mascota, el tipo de mascota y cuando la adoptó, 
incluyendo aquellas personas que aún no han adoptado ninguna mascota.
 */


/*
Muestra los nombre de los animales, nombre del tipo de animal, la fecha de adopcion.
Aunque no hayan sido adoptados. Ordena por tipo de animal.
 */


/*
Cuenta los animales existentes por tipo. 
Aunque estos no hayan sido adoptados. 
Ordena por tipo de animal.
 */


/*
Cuenta los animales existentes que se llamen igual.
Ordena por nombre.
 */


/*
Cuenta los animales existentes por nombre del animal, cuyo nombre empice por B. 
Ordena por nombre
 */


/* 
Muestra el tipo de animal y los animales que hay de ese tipo. 
Tiene que contar tanto si hay animales de ese tipo como si no los hay. 
Ordena por nombre del tipo

Ejecuta esto previamente 
insert into tipo_animal (nombre) values ('Oveja');

Para Oveja debe salir 0 en la cuenta.
 */
