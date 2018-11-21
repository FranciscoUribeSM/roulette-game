# JUEGO DE LA RULETA

Aplicación desarrollada en Ruby on Rails que simula un grupo dinámico de personas que juegan a la ruleta en un casino. Su objetivo es monitorear una mesa de casino donde sus jugadores modifican sus apuestas dependiendo del clima. 

### Especificaciones 
- Vista para agregar y modificar jugadores.
- Los jugadores parten con $10.000 por defecto.
- Todos los jugadores que tengan dinero participan en una partida de ruleta cada 3 minutos.
- **Rondas de juego:** Los jugadores apuestan entre un 8% y 15% del total de dinero que poseen. Si tienen $1.000 o menos, van All In. Si no les queda dinero, no apuestan.
- **Apuesta**: Puede variar dependiendo del clima de Santiago de Chile. En caso de que esté pronosticado una temperatura superior a 20 ºC dentro de los próximos 7 días, las apuestas son más conservadoras y cambian a un valor aleatorio entre 3% y 7%.
- **El modo de apuesta**: Un jugador puede apostar a Verde, Rojo o Negro con un 2%, 49% y 49% de probabilidad respectivamente.
- Un jugador recupera el doble de lo apostado si acierta su apuesta, cuando ésta sea Rojo o Negro, y recupera 15 veces lo apostado en caso de acertar Verde. En caso de perder la apuesta, no recupera nada.
- La ruleta entrega resultados con la misma probabilidad que los jugadores hacen apuestas, es decir, Verde 2%, Rojo 49% y Negro 49%.
- Al final del día, todos los jugadores reciben $10.000.
- Debe existir una vista donde se muestren todas las rondas transcurridas, con la apuesta de cada jugador y el resultado de la ruleta.

## Instalación 

La aplicación fue desarrollada con ruby@2.5.3 y rails@5.2.1.
```sh
$ bundle install 
$ whenever --update-crontab
$ rake db:migrate
$ rails s
```

## Complementos 
##### Cron jobs 
Se utilizo [whenever](https://github.com/javan/whenever) para la utilización de **cron jobs** en el entorno de desarrollo, y **[Scherudes Heroku](https://devcenter.heroku.com/articles/scheduler)** en producción.

>Scherudes Heroku permite realizar tareas con una frecuencia mínima de 10 minutos. Por esta razón, las rondas no se realizan cada 3 min como se requería en producción. 

##### API 

Para obtener el pronostico del clima de los próximos 7 días se utilizo  la API  [WorldWeather](https://www.worldweatheronline.com/).

##### Diseño 

Para el diseño se utilizo [Bootstrap 4](https://getbootstrap.com/docs/4.1/getting-started/introduction/), y para la paginación [will_paginate](https://github.com/mislav/will_paginate) en el listado de rondas y jugadores. 

------

## Modelo 
![](https://github.com/FranciscoUribeSM/roulette-game/blob/master/Modelo.png?raw=true)

*Weathers*, se utilizo para registrar el pronostico de temperatura solo una vez por día. 
La tabla Bets aparte de registrar la cantidad, color y ganancia de la apuesta, guarda el saldo del jugador al momento de realizar cada apuesta para generar un registro histórico por cada jugador.

