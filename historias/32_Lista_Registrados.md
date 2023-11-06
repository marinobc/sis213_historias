# Historia de Usuario #32: Listado de Tarjetas para Usuarios Registrados

### Título: Acceso Completo al Listado de Tarjetas

**Como** usuario registrado de la plataforma,

**Quiero** ver todas las tarjetas a la venta con precio.

**Para** pujar, comprar y ver los precios de las tarjetas.

## Criterios de Aceptación:

1. **Acceso Restringido para Usuarios Registrados**:
   - Dado que soy un usuario registrado.
   - Cuando accedo al sitio web.
   - Entonces quiero tener acceso exclusivo a funcionalidades avanzadas como pujar, comprar y ver precios detallados.

2. **Interacción con el Listado**:
   - Dado que estoy explorando el listado de tarjetas.
   - Cuando encuentro una tarjeta de interés.
   - Entonces quiero tener la opción de pujar o comprar directamente desde el listado.

3. **Información de Precios Visible**:
   - Dado que tengo permisos de usuario completo.
   - Cuando miro las tarjetas en el listado.
   - Entonces espero ver los precios listados claramente junto a cada tarjeta.

4. **Detalles de la Subasta**:
   - Dado que algunas tarjetas están disponibles mediante subasta.
   - Cuando accedo a estos items en el listado.
   - Entonces quiero ver los detalles de la subasta, incluyendo el precio actual de la puja y el tiempo restante.

5. **Función de Compra Directa**:
   - Dado que prefiero comprar sin participar en una subasta.
   - Cuando selecciono una tarjeta con opción de compra directa.
   - Entonces quiero realizar la compra inmediatamente, con confirmación del pedido.

6. **Filtrado y Búsqueda Avanzada**:
   - Dado que tengo intereses específicos.
   - Cuando uso la función de búsqueda.
   - Entonces quiero filtrar tarjetas por nombre.

9. **Historial de Pujas y Compras**:
   - Dado que participo activamente en subastas y compras.
   - Cuando accedo a mi perfil de usuario.
   - Entonces quiero tener un historial de todas mis pujas y compras para un seguimiento fácil.

10. **Notificaciones en Tiempo Real**:
    - Dado que las subastas pueden cambiar rápidamente.
    - Cuando estoy pujando en un item.
    - Entonces quiero recibir notificaciones en tiempo real si soy sobrepujado o si hay cambios importantes en el estado de la subasta.

11. **Comparación de Precios**:
   - Dado que quiero asegurarme de obtener un buen precio.
   - Cuando busco tarjetas.
   - Entonces quiero poder comparar los precios de tarjetas similares disponibles en la plataforma.

## Analisis

### Pantalla de mercado

A continuación se presenta la pantalla de mercado, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso

![Crear subasta](/imagenes/Mercado.png)

### Pantalla de subasta especifica

A continuación se presenta la pantalla de subasta especifica, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona alguna carta y es redirigido a los detalles de la misma

![Crear subasta](/imagenes/Subasta.png)

### Pantalla de Mis compras

A continuación se presenta la pantalla de Mis compras, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona Mis Compras

![Crear subasta](/imagenes/Mis%20compras.png)

### Pantalla de Mis Subastas

A continuación se presenta la pantalla de Mis Subasta, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona Mis Subastas

![Crear subasta](/imagenes/Mis%20subastas.png)


## Diseño Endpoints

#### Pantalla de Listado de Tarjetas para Usuarios Registrados

### 1. **Para obtener la lista de tarjetas a la venta con precio:**

Request:
```http
GET /api/v1/cards
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "cardCode": "Codigo de Carta",
    "name": "Nombre de la Carta",
    "currentBid": 150.00,
    "buyNowPrice": 200.00,
    "auctionEndTime": "2023-12-05T14:00:00Z"
  },
  // ... más cartas
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron tarjetas a la venta. Intentelo de nuevo mas tarde."
}
```

### 2. **Para obtener los detalles de una carta específica y opción de pujar o comprar:**

Request:
```http
GET /api/v1/cards/{cardCode}
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "cardCode": "Codigo de Carta",
  "name": "Nombre de la Carta",
  "description": "Descripción detallada",
  "currentBid": 150.00,
  "buyNowPrice": 200.00,
  "auctionEndTime": "2023-12-05T14:00:00Z",
  "image": "URL"
}
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "La carta con el código especificado no se encontro."
}
```

---
### 3. **WebSocket para recibir el precio de la carta en tiempo real:**

```json
{
  "type": "onmessage",
  "path": "/ws/card-bid",
  "description": "WebSocket que recibe actualizaciones del precio de la carta en tiempo real."
}
```

### 4. **WebSocket para enviar una puja para la carta en tiempo real:**

```json
{
  "type": "send",
  "path": "/ws/make-bid",
  "description": "WebSocket que permite al usuario enviar una puja para la carta en tiempo real."
}
```
---

### 5. **Para obtener el historial de pujas y compras de un usuario:**

Request:
```http
GET /api/v1/auctioning/users/{userId}/cards
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "auctionId": "Codigo de Transaccion",
    "cardCode": "Codigo de Carta",
    "bidAmount": 150.00,
    "bidTime": "2023-11-05T12:00:00Z",
    "status": "Winning"
  },
  // ... más historial
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron pujas del usuario. Intentelo de nuevo mas tarde."
}
```

### 6. **Para obtener la lista de cartas adquiridas en subastas por un usuario:**

Request:
```http
GET /api/v1/ownership/users/{userId}/cards
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "auctionId": "Codigo de Transaccion",
    "cardCode": "Codigo de Carta",
    "purchasePrice": 180.00,
    "purchaseDate": "2023-11-04T19:00:00Z",
    "status": "Owned"
  },
  // ... más cartas
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron adquisiciones del usuario. Intentelo de nuevo mas tarde."
}
```

## Whislist

**Guardar Búsquedas o Items**:
   - Dado que he encontrado tarjetas de interés pero no estoy listo para hacer una compra.
   - Cuando navego por la plataforma.
   - Entonces quiero tener la opción de guardar mis búsquedas o items específicos para revisarlos más tarde.
