# Historia de Usuario #50: Gestión de subasta

### Título: Gestión de subasta con deadline

**Como** usuario vendedor.

**Quiero** poder monitorear la carta que estoy subastando.

**Para** poder terminar la subasta y ver el comprador.


## Criterios de Aceptación:

1. **Monitorización en Tiempo Real**:
   - Dado que soy un usuario vendedor con una tarjeta en subasta.
   - Cuando accedo a la sección de "Mis Subastas".
   - Entonces debo poder ver el estado actual de la subasta en tiempo real, incluyendo la cuenta regresiva del tiempo restante y las ofertas actuales.

2. **Notificaciones de Ofertas**:
   - Dado que tengo una tarjeta en subasta.
   - Cuando un comprador hace una oferta.
   - Entonces quiero recibir una notificación inmediata para poder seguirla y reaccionar según sea necesario.

3. **Detalle de Ofertas**:
   - Dado que estoy monitoreando mi subasta.
   - Cuando reviso el detalle de la subasta.
   - Entonces debo poder ver un historial de todas las ofertas realizadas, incluyendo la cantidad de la oferta y el momento en que se realizó.

4. **Finalización Automática de la Subasta**:
   - Dado que la subasta tiene un tiempo límite establecido.
   - Cuando este tiempo se agote.
   - Entonces la subasta debe cerrarse automáticamente y el sistema debe asignar el artículo al mayor postor.

5. **Información del Ganador**:
   - Dado que la subasta ha terminado.
   - Cuando consulto los resultados de la subasta.
   - Entonces quiero ver la información del ganador o del mayor postor con el que la plataforma facilitará la transacción.

6. **Función de Cierre Manual**:
   - Dado que quiero tener control sobre mi subasta.
   - Cuando lo decida antes de la fecha límite.
   - Entonces quiero tener la opción de cerrar la subasta manualmente si así lo deseo.

7. **Acciones Post-Subasta**:
   - Dado que la subasta ha concluido.
   - Cuando el ganador ha sido determinado.
   - Entonces quiero que la plataforma facilite el proceso de pago y entrega.

8. **Historial de Subastas**:
    - Dado que puedo tener múltiples subastas a lo largo del tiempo.
    - Cuando reviso mi perfil de usuario.
    - Entonces quiero tener acceso a un historial de todas mis subastas pasadas y su estado final, incluyendo las tarjetas vendidas, los precios finales y los compradores.


## Analisis

### Pantalla de Mis Subastas

A continuación se presenta la pantalla de mercado, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona Mis Subastas

![Crear subasta](/imagenes/Mis%20subastas.png)

### Pantalla de Mis Compras

A continuación se presenta la pantalla de mercado, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona Mis Compras

![Crear subasta](/imagenes/Mis%20compras.png)

### Pantalla de subasta especifica

A continuación se presenta la pantalla de subasta especifica, cuyo funcionamiento es.

1. El usuario inicio sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona alguna carta y es redirigido a los detalles de la misma

![Crear subasta](/imagenes/Subasta.png)


## Diseño Endpoints

#### Pantalla de "Mis Subastas" 

### 1. **Para obtener estado actual de la subasta:**

Request
```http
GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards
Accept: application/json
Authorization: Bearer {JWT}
```
Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "cardCode": "Codigo de carta",
    "currentPrice": 150.00,
    "timeRemaining": "01:15:30",
    "bidCount": 5
  },
  // ... otras cartas si hay más subastas activas
]
```
Response: No hay subastas (Código de estado HTTP: 404)
```json
{
  "error": "No se encontraron subastas activas para este usuario."
}
```

Response: Fallo de autenticación (Código de estado HTTP: 401)
```json
{
  "error": "No autorizado. Por favor inicie sesión."
}
```

---
### 2. **Notificaciones de Ofertas**

#### WebSocket Listener para ofertas en tiempo real:
```plaintext
WebSocket: /ws/card-bid/{userId}
```

**WebSocket Notification:**
```json
{
  "cardCode": "Codigo de carta",
  "newPrice": 160.00,
  "bidder": "Nombre de usuario",
  "time": "2023-11-03T10:15:30Z"
}
```
---

### 3. **Historial de todas las ofertas**

#### Request para obtener historial de ofertas:
```http
GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/bids
Accept: application/json
Authorization: Bearer {JWT}
```
Response: Exito (Código de estado HTTP: 200)
```json
[
  {
    "bidder": "Nombre de usuario",
    "amount": 150.00,
    "time": "2023-11-03T09:15:30Z"
  },
  // ... otras oferta si hay más ofertas
]
```
Response: No se encuentran ofertas (Código de estado HTTP: 404)
```json
{
  "error": "No se encontraron ofertas para esta carta."
}
```

### 5. **Para obtener información del ganador**

Request:
```http
GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/winner
Accept: application/json
Authorization: Bearer {JWT}
```

Response: Exito (Código de estado HTTP: 200)
```json
{
  "winnerId": "Nombre de usuario",
  "amount": 160.00,
  "time": "2023-11-03T10:20:00Z"
}
```

Response: Subasta aún activa (Código de estado HTTP: 403)
```json
{
  "error": "La subasta aún está activa. No se puede mostrar información del ganador."
}
```

### 6. **Función de Cierre Manual - Cerrar subasta antes de tiempo**

Request
```http
POST /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/closure
Authorization: Bearer {JWT}
```

Response: Exito (Código de estado HTTP: 200)
```json
{
  "message": "Subasta cerrada exitosamente. Ganador notificado."
}
```
Response: Error en el cierre (Código de estado HTTP: 400)
```json
{
  "error": "No se pudo cerrar la subasta. Puede que ya esté cerrada o no exista."
}
```

### 7. **Historial de Subastas Pasadas**

#### Request para ver el historial de subastas pasadas:
```http
GET /api/v1/auctioning/users/{userId}/cards/history
Accept: application/json
Authorization: Bearer {JWT}
```

Response: Exito (Código de estado HTTP: 200)
```json
[
  {
    "cardCode": "Codigo de carta",
    "status": "Closed",
    "winnerId": "id usuario",
    "finalPrice": 160.00,
    "closureTime": "2023-11-03T10:20:00Z"
  },
  // ... otras cartas de subastas pasadas
]
```
Response: Historial no encontrado (Código de estado HTTP: 404)
```json
{
  "error": "Historial de subastas no encontrado para este usuario."
}
```