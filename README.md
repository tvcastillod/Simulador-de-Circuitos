# Simulador-de-Circuitos-de-Corriente-Continua

# Integrantes
| Nombre | Github nickname |
| ------ | --------------- |
| Omar David Velasquez Pinto | omdvelasquezpi |
| Tania Valentina Castillo Delgado | tvcastillod |

# Introducción
El campo de la electricidad se determina como un espacio principal en el área de las ciencias y de la ingeniería que, al día de hoy, interviene directamente en el estilo de vida de muchas personas. De igual forma, la electricidad es un eje fundamental para el desarrollo tecnológico, por lo que es clave entender las aplicaciones y el comportamiento de los fenómenos físicos asociados. Aplicando los conceptos fundamentales de la programación orientada a objetos, este proyecto se basa en la creación de un simulador de circuitos eléctricos de corriente contínua, un método práctico y al alcance de cualquier usuario que permite interiorizar el comportamiento fundamental y lineal de circuitos básicos que representan conceptos como la ley de Ohm. 

## Problemática
Cuando se habla de simuladores de circuitos, hoy día podemos encontrar de todo tipo, sin embargo, la gran mayoría se presenta con aplicaciones que solo pueden entender o manejar, personas con un fundamento teórico o práctico del tema, y a veces se debe tener un alto contenido académico para su utilización, generando esto que no sea accesible a todo tipo de personas, sin importar el conocimiento que se tenga de circuitos, por lo que se hace pertinente crear un simulador que sea más fácil de entender y manejar.

## Marco teórico
Dado que en este proyecto se busca incentivar a las personas que tienen poco conocimiento del manejo circuitos, es pertinente evaluar el papel que tiene un simulador de circuitos académica y personalmente. Este es de gran utilidad a la hora de evaluar el buen funcionamiento de un circuito real, ya que nos permite ver cómo debería funcionar y los resultados aproximados que debería tener, además de ayudar a la detección de errores en el diseño y ejecución de un circuito. En principio, se deben tener en cuenta los siguientes conceptos:

[Electricidad](https://es.wikipedia.org/wiki/Electricidad): Es el fenómeno físico que proviene de la existencia e interacción de cargas eléctricas.

[Circuito eléctrico](https://es.wikipedia.org/wiki/Circuito): También denominada red eléctrica es una interconexión de elementos eléctricos unidos entre sí en una trayectoria cerrada de forma que pueda fluir continuamente una corriente eléctrica.

[Carga](https://es.wikipedia.org/wiki/Carga_el%C3%A9ctrica): Es la cantidad de electricidad responsable de los fenómenos eléctricos. Su unidad es el coulomb [C].

[Corriente eléctrica](https://es.wikipedia.org/wiki/Corriente_el%C3%A9ctrica): Es la razón de cambio temporal de la carga eléctrica que pasa por un punto dado. Depende, entre otras cosas, del área en el que fluyen las cargas. Generalmente, el flujo de la corriente también depende de la convención de las cargas, es decir, el flujo de la corriente se representa como el flujo de cargas positivas. Su unidad es el ampere [A]. 

[Corriente contínua](https://es.wikipedia.org/wiki/Corriente_continua): También definida como corriente directa, es la corriente que tiene magnitud constante.

[Tensión (Diferencia de potencial)](https://es.wikipedia.org/wiki/Tensi%C3%B3n_(electricidad)): La tensión o voltaje a través de un elemento es el trabajo necesario (energía necesaria) para mover una carga eléctrica unitaria y positiva desde su terminal negativo al otro terminal, el positivo. Su unidad es el volt [V].

[Energía](https://es.wikipedia.org/wiki/Energ%C3%ADa): Capacidad de realizar trabajo. Su unidad es el joule [J]. En general, la energía eléctrica se puede convertir en energía mecánica, química o térmica.

[Potencia](https://es.wikipedia.org/wiki/Potencia_el%C3%A9ctrica): Es la cantidad de energía entregada o absorbida en cierto tiempo. Su unidad es el watt [W]. Al igual que la corriente, la potencia se define dependiendo de la dirección del flujo de cargas. En este caso, si la corriente que pasa por el elemento entra por su terminal positivo, se denomina potencia absorbida. Por otra parte, si la corriente entra al elemento por su terminal negativa se denomina potencia suministrada.

[Componente electrónico](https://es.wikipedia.org/wiki/Componente_electr%C3%B3nico): Se denominan componentes electrónicos aquellos dispositivos que forman parte de un circuito electrónico.

[Elemento lineal](https://es.wikipedia.org/wiki/Circuito_lineal): Es un elemento que satisface las propiedades de superposición y de homogeneidad.

[Elemento activo](https://es.wikipedia.org/wiki/Fuente_de_alimentaci%C3%B3n): Elemento capaz de suministrar energía

[Elemento pasivo](https://es.wikipedia.org/wiki/Componente_electr%C3%B3nico#Componentes_pasivos): Elemento capaz de absorber energía.

[Resistencia](https://es.wikipedia.org/wiki/Resistencia_el%C3%A9ctrica): Es la propiedad física de un elemento o un dispositivo que impide el flujo de corriente. Se representa con el símbolo R. Su unidad es el ohm.

[Ley de Ohm](https://es.wikipedia.org/wiki/Ley_de_Ohm): Es la relación lineal entre la corriente y el voltaje de un elemento, que corresponde a la fórmula v = Ri. 

[Voltímetro](https://es.wikipedia.org/wiki/Volt%C3%ADmetro): Es un dispositivo utilizado principalmente para medir tensiones o voltajes. Se conecta en paralelo al elemento del que se desea obtener la tensión

[Amperímetro](https://es.wikipedia.org/wiki/Amper%C3%ADmetro): Es un dispositivo utilizado para medir corrientes eléctricas. Se debe conectar en serie con el elemento y la trayectoria de la cual se quiere conocer la corriente.

[Interruptor](https://es.wikipedia.org/wiki/Interruptor): Es un elemento que tiene dos estados: abierto, que corresponde a un circuito abierto; o cerrado, que corresponde a un corto circuito.

[Conductor](https://es.wikipedia.org/wiki/Conductor_el%C3%A9ctrico): Se conoce como conductor a un elemento físico caracterizado por su capacidad de permitir el flujo de cargas eléctricas con muy poca resistencia.

[Bombilla](https://es.wikipedia.org/wiki/L%C3%A1mpara_el%C3%A9ctrica): Es un elemento que se caracteriza por convertir la energía eléctrica en energía lumínica o luz.

Referencias:

[1] M. Montijano Moreno, “La simulación de circuitos en el aula de Electrónica”, [online] revista digital para profesionales en la enseñanza, N°4, Septiembre, 2009. Disponible en: https://www.feandalucia.ccoo.es/docu/p5sd5442.pdf

[2] Dorf, R., Svoboda, J. Introduction to electric circuits (2014). Novena edición. John Wiley & Sons, Inc. EEUU.

## Antecedentes
* Simulador de circuito electrónico (Applet Java): http://www.falstad.com/circuit-java/
* Simulador de circuitos eléctricos (Java): http://www.aulas-fisica-quimica.com/9e_01.html

# Objetivos

## General
Crear un simulador de circuitos con aspecto visual agradable, más gráfico y menos simbólico, que logre incentivar al público en general al manejo de circuitos de una manera fácil de entender y manejar, implementando la programación orientada a objetos.

## Específicos
* Usar el concepto de polimorfismo, subtyping, para la creación de clases y subclases con el fin de facilitar el manejo y funcionalidad de los elementos (simplificar el código).
* Representar el comportamiento de componentes eléctricos de un circuito de manera gráfica, rápida y fácil de entender.
* Simplificar el diseño de circuitos para facilitar su análisis y comprensión.

# Requisitos
Lenguaje: Processing
Librerías
* [Dashed Lines](https://github.com/garciadelcastillo/-dashed-lines-for-processing-): Esta librería puede ser utilizada para representar el flujo de corriente del circuito.
* Geomerative: Puede ser utilizada para realizar las conexiones del circuito.
