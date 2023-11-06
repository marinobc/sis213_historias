# Historia de Usuario #40: Busqueda de Item

### Título: Busqueda de tarjeta

**Como** usuario comprador o vendedor.

**Quiero** poder ver si un item esta disponible en mi ubicacion. Ademas de ver sus detalles.

**Para** poder comprar tarjetas o evaluar su costo.


## Criterios de Aceptación:

1. **Funcionalidad de Búsqueda**:
   - Dado que soy una persona.
   - Cuando accedo a la plataforma.
   - Entonces quiero tener una función de búsqueda que me permita buscar tarjetas por nombre.

2. **Filtro por Ubicación**:
   - Dado que quiero encontrar tarjetas disponibles en mi área geográfica.
   - Cuando utilizo la función de búsqueda.
   - Entonces debo poder filtrar los resultados por mi ubicación o especificar una diferente.

3. **Disponibilidad en Tiempo Real**:
   - Dado que he encontrado una tarjeta que me interesa.
   - Cuando miro los detalles del item.
   - Entonces el sistema debe indicarme si la tarjeta está disponible actualmente.

4. **Visualización de Detalles**:
   - Dado que quiero saber más sobre una tarjeta específica.
   - Cuando selecciono un item en los resultados de búsqueda.
   - Entonces quiero ver todos los detalles relevantes como precio, condición de la tarjeta, fotos y cualquier otro dato de interés.

5. **Filtrar Resultados**:
   - Dado que he realizado una búsqueda.
   - Cuando veo la lista de items.
   - Entonces quiero tener opciones para filtrar los resultados por si es subasta o precio fijo.

6. **Proceso de Compra o Subasta Integrado**:
   - Dado que estoy interesado en una tarjeta para compra o quiero participar en una subasta.
   - Cuando veo los detalles del item.
   - Entonces no se mostrará información de contacto del vendedor directamente, sino que debo poder participar en la subasta o iniciar un proceso de compra a través de la plataforma.

## Analisis

### Pantalla de mercado publica

A continuación se presenta la pantalla de mercado, cuyo funcionamiento es.

1. El usuario entra en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario busca algun nombre de carta

![Crear subasta](/imagenes/Mercado%20Publico.png)

### Pantalla de mercado registrado

A continuación se presenta la pantalla de mercado, cuyo funcionamiento es.

1. El usuario inicia sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario busca algun nombre de carta

![Crear subasta](/imagenes/Mercado.png)

## Diseño Endpoints

#### Pantalla de Listado de Tarjetas para Visitantes

### 1. **Para realizar una búsqueda filtrada por nombre:**

Request:
```http
GET /api/v1/cards?name=NombreBuscado
Accept: Application/json
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "auctionId": "Codigo de Transaccion",
    "cardCode": "Codigo de Carta",
    "name": "Nombre de la Carta",
    "transactionType": "Subasta o Compra",
    "auctionEndTime": "2023-12-06T20:00:00Z"
  },
  // ... resultados filtrados
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron cartas que coincidan con la busqueda."
}
```

#### Pantalla de Listado de Tarjetas para Usuarios Registrados

### 2. **Para realizar una búsqueda filtrada por nombre:**

Request:
```http
GET /api/v1/cards?name=NombreBuscado
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
[
  {
    "auctionId": "Codigo de Transaccion",
    "cardCode": "Codigo de Carta",
    "name": "Nombre de la Carta",
    "currentBid": 120.00,
    "buyNowPrice": 150.00,
    "auctionEndTime": "2023-12-06T20:00:00Z"
  },
  // ... resultados filtrados
]
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "No se encontraron cartas que coincidan con la busqueda."
}
```
