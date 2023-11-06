# Historia de Usuario #25: Listado de Tarjetas Disponibles

### Título: Listado Público de Tarjetas

**Como** visitante de la plataforma.

**Quiero** poder listar todas las tarjetas a la venta de forma pública.

**Para** explorar la variedad de tarjetas disponibles antes de decidir registrarme.

## Analisis

### Pantalla de inicio

A continuación se presenta la pantalla de inicio, cuyo funcionamiento es.

1. El usuario entra en la pagina web.

![Crear subasta](/imagenes/Mercado%20Publico.png)

### Pantalla de subasta especifica

A continuación se presenta la pantalla de subasta especifica, cuyo funcionamiento es.

1. El usuario entra en la pagina web.
2. Presiona el boton de ver mas en cualquier carta

![Crear subasta](/imagenes/Subasta%20publica.png)


## Criterios de Aceptación:

1. **Acceso Público al Listado**:
   - Dado que soy un visitante de la plataforma.
   - Cuando accedo al sitio web.
   - Entonces quiero poder ver un listado de todas las tarjetas disponibles para la venta sin necesidad de registrarme.

2. **Visualización de Información Esencial**:
   - Dado que estoy viendo el listado de tarjetas.
   - Cuando navego por la lista.
   - Entonces espero ver información esencial como el nombre del item, imagen y si es una venta directa o una subasta.

3. **Actualizaciones en Tiempo Real**:
   - Dado que las tarjetas pueden venderse en cualquier momento.
   - Cuando estoy en la página de listado.
   - Entonces espero que la información se actualice en tiempo real para reflejar la disponibilidad más reciente de las tarjetas.

4. **Filtrado por Ubicación**:
   - Dado que la ubicación puede ser un factor en mi decisión de compra.
   - Cuando examino el listado.
   - Entonces quiero tener la opción de filtrar tarjetas por su disponibilidad geográfica.

5. **Acceso a Detalles del Item**:
   - Dado que encuentro una tarjeta de mi interés en el listado.
   - Cuando hago clic en ella.
   - Entonces quiero ser llevado a una página con más detalles del item sin necesidad de registrarme.

6. **Instrucciones para Registro**:
   - Dado que estoy interesado en una tarjeta después de ver el listado.
   - Cuando deseo realizar una compra o participar en una subasta.
   - Entonces debe haber un llamado a la acción claro para registrarme en la plataforma y obtener acceso completo a las funcionalidades.


## Diseño Endpoints

### Pantalla de Listado de Tarjetas para Visitantes

### 1. **Para obtener la lista de tarjetas disponibles**

Request:
```http
GET /api/v1/cards
Accept: Application/json
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "cardCode": "Codigo de Carta",
    "name": "Nombre de la Carta",
    "transactionType": "Subasta o Compra",
    "auctionEndTime": "2023-12-05T14:00:00Z"
  },
  // ... más cartas
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron tarjetas en su ubicacion. Intentelo de nuevo mas tarde."
}
```

### 2. **Para obtener los detalles de una carta específica y opción de pujar o comprar:**

Request:
```http
GET /api/v1/cards/{cardCode}
Accept: Application/json
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "cardCode": "Codigo de Carta",
  "name": "Nombre de la Carta",
  "description": "Descripción detallada",
  "transactionType": "Subasta o Compra",
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