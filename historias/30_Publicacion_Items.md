# Historia de Usuario #30: Publicacion de tarjeta

### Título: Publicacion de item

**Como** usuario vendedor.

**Quiero** poder registrar un item subiendo fotos y estableciendo precio. Ademas de la modalidad precio fijo o subasta. Ademas de disponibilidad Geográfica.

**Para** poder vender mis tarjetas.


## Criterios de Aceptación:

1. **Interfaz de Subida de Fotos**:
   - Dado que soy un usuario vendedor.
   - Cuando accedo a la opción de registrar una nueva subasta.
   - Entonces quiero tener una interfaz clara donde pueda subir hasta 4 imágenes que cumplan con los requisitos de resolución y tamaño especificados.

2. **Validación de Imágenes**:
   - Dado que he subido fotos para una tarjeta.
   - Cuando intento registrar el item.
   - Entonces el sistema debe validar que las imágenes cumplen con la resolución y el tamaño requeridos antes de aceptarlas.

3. **Definición de Precio**:
   - Dado que quiero vender una tarjeta.
   - Cuando registro el item.
   - Entonces debo tener la opción de establecer un precio fijo o iniciar una subasta con un precio base.

4. **Configuración de la Subasta**:
   - Dado que he elegido vender una tarjeta mediante subasta.
   - Cuando registro el item.
   - Entonces quiero poder establecer un tiempo límite para la subasta y un precio inicial.

5. **Indicación de Disponibilidad Geográfica**:
   - Dado que quiero coordinar entregas en o permitir recogidas locales.
   - Cuando registro el item.
   - Entonces debo poder indicar la ciudad o área geográfica donde la tarjeta está disponible para ser recogida o entregada.

6. **Confirmación de Publicación**:
   - Dado que he ingresado toda la información necesaria para vender una tarjeta.
   - Cuando envío el formulario de registro del item.
   - Entonces quiero recibir una confirmación de que la tarjeta ha sido publicada con éxito en la plataforma.

7. **Edición Posterior al Registro**:
   - Dado que he registrado una tarjeta para la venta.
   - Cuando necesite hacer cambios en la información o eliminar la publicación.
   - Entonces debo tener la capacidad de editar o retirar mi publicación.

8. **Previsualización de Publicación**:
   - Dado que he completado los detalles de mi publicación de venta.
   - Cuando estoy a punto de publicar.
   - Entonces quiero poder previsualizar cómo aparecerá mi anuncio a los compradores potenciales.

9. **Información de Coordinación para la Entrega**:
    - Dado que las entregas se coordinan entre vendedor y comprador.
    - Cuando registro el item.
    - Entonces debo especificar si la entrega se hará en persona en la ciudad de ubicación o si se utilizará la plataforma para coordinar un punto de encuentro dentro de la misma ciudad.


## Analisis

### Pantalla de creacion de nueva subasta

A continuación se presenta la pantalla de creacion de subasta, cuyo funcionamiento es.

1. El usuario hizo clic previamente en Crear Nueva Subasta.
2. El usuario deberá tener listo el codigo de la carga y las images para llenar el formulario.

![Crear subasta](/imagenes/Crear%20subasta.png)

### Pantalla de modificacion una subasta

A continuación se presenta la pantalla de modificacion de subasta, cuyo funcionamiento es.

1. El usuario hizo clic en editar en una de sus subastas en curso.

![Crear subasta](/imagenes/Editar%20subasta.png)

## Diseño Endpoints

### Pantalla de creacion de nueva subasta

1. Para buscar informacion de una carta a subastar:

### Request:
```http
GET BASE_URL/api/v1/cards/{cardCode}/info
Accept: Application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "cardCode": "Codigo de Carta",
  "name": "Nombre de la Carta",
  "rarity": "Rareza de la Carta",
  "price": "Precio de Mercado Recomendado",
  "image": "URL"
}

```

Response: No encontrado (Código de estado HTTP: 404)
```json
{
  "error": "La carta con el código especificado no se ha encontrado."
}
```

Response: Falla de autenticación (Código de estado HTTP: 400)
```json
{
  "error": "Falta el token de autenticación en la solicitud. Recargue la pagina y vuelva a intentarlo."
}
```

2. Para subir imagenes de la carta

### Request:
```http
POST BASE_URL/api/v1/auctioning/users/{userId}/cards/{cardCode}/images
Content-Type: multipart/form-data
Authorization: Bearer JWT

# Form data:
# - image1: (file)
# - image2: (file)
# - image3: (file)
# - image4: (file)
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "message": "Imágenes subidas correctamente.",
  "images": [
    "BASE_URL/api/v1/cards/{cardCode}/image1.jpg",
    "BASE_URL/api/v1/cards/{cardCode}/image2.jpg",
    "BASE_URL/api/v1/cards/{cardCode}/image3.jpg",
    "BASE_URL/api/v1/cards/{cardCode}/image4.jpg"
  ]
}
```

Response: Error en la validación de la imagen (Código de estado HTTP: 400)
```json
{
  "error": "Una o más imágenes no cumplen con los requisitos de resolución o tamaño."
}
```

3. Para crear una subasta con precio y disponibilidad geográfica

### Request:
```http
POST BASE_URL/api/v1/auctioning/users/{userId}/cards
Content-Type: application/json
Authorization: Bearer JWT

{
  "cardCode": "Codigo de Carta",
  "startingPrice": 100.00,
  "fixedPrice": null, // Nulo si es subasta, un valor si es precio fijo
  "auctionEndTime": "2023-11-30T20:00:00Z", // Nulo si es precio fijo
  "geographicAvailability": "Ciudad"
}
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "message": "Subasta creada con éxito.",
  "auctionDetails": {
    "auctioningId": "Codigo de la Transaccion",
    "cardCode": "Codigo de Carta",
    "currentPrice": 100.00,
    "fixedPrice": null,
    "auctionEndTime": "2023-11-30T20:00:00Z",
    "geographicAvailability": "Ciudad XYZ"
  }
}
```

Response: Fallo (Código de estado HTTP: 400)
```json
{
  "error": "Información de la subasta incompleta o incorrecta."
}
```

3. API para obtener la confirmación de la publicación de la subasta

### Request:
```http
GET BASE_URL/api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}
Accept: application/json
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "auctioningId": "Codigo de la Transaccion",
  "cardCode": "Codigo de Carta",
  "images": [
    "BASE_URL/api/v1/cards/{cardCode}/image1.jpg",
    // Más imágenes si están disponibles
  ],
  "startingPrice": 100.00,
  "fixedPrice": null,
  "auctionEndTime": "2023-11-30T20:00:00Z",
  "geographicAvailability": "Ciudad",
  "status": "Publicado"
}
```

Response: No encontrado (Código de estado HTTP: 404)
```json
{
  "error": "Subasta no encontrada."
}
```
