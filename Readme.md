**Funcion**

La funcion tiene como objetivo calcular el promedio de los productos realizados por el cliente y si no tiene pedidos registrados arroje 0

**Para ejecutar la funcion se debe hacer una consulta SELECT de la tabla a la que le corresponda con el nombre de la funcion**

**Vista**

La vista muestra un filtro de pedidos y sedes

**se ejecuta con SELECT y el nombre de la vista**

**Consulta**

la consulta debe arrojar solo el precio de los productos que sean mayor a su promedio

**Para ejecutar se hizo una subconsulta en where donde se calculo el avg**

**trigger**

el trigger debe cambiar el precio de la tabla auditar_precios cuando se le inserte uno nuevo
**Se uso old <> new (para eso se actualizo el campo precio con UPDATE SET) luego al buscar la tabla se debe reflegar la actualizacion del nuevo precio**