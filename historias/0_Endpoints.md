# Autenticación y Autorización:
1. `GET BASE_URL/api/v1/authorization`: Redirecciona al usuario a la federación de inicio de sesión para autenticación.
2. `POST BASE_URL/api/v1/authorization/callback`: Procesa el callback de Auth0 y devuelve tokens de autorización.
3. `POST BASE_URL/api/v1/authorization/refresh`: Refresca el token JWT para mantener la sesión activa.

# Registro de Usuario:
1. `GET BASE_URL/api/v1/authorization/registration`: Redirecciona a la federación de inicio de sesión para registro.
2. `GET BASE_URL/api/v1/authorization/registration/callback?code={Codigo de autorizacion de auth0}`: Procesa el callback de registro de Auth0 y confirma el registro.

# Publicación de Item:
1. `GET BASE_URL/api/v1/cardInfo/{cardCode}`: Busca información de una carta para subasta.
2. `POST BASE_URL/api/v1/auctioning/users/{userId}/cards/{cardCode}/images`: Sube imágenes de una carta.
3. `POST BASE_URL/api/v1/auctioning/users/{userId}/cards`: Crea una subasta con detalles de la carta.
4. `GET BASE_URL/api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}`: Obtiene detalles de la publicación de la subasta.

# Listado de Tarjetas para Usuarios Registrados:
1. `GET /api/v1/cards`: Obtiene la lista de tarjetas disponibles con precios.
2. `GET /api/v1/cards/{cardCode}`: Obtiene detalles de una carta específica.
3. WebSocket para recibir el precio de la carta en tiempo real.
4. WebSocket para enviar una puja para la carta en tiempo real.
5. `GET /api/v1/auctioning/users/{userId}/cards`: Obtiene el historial de pujas y compras de un usuario registrado.
6. `GET /api/v1/ownership/users/{userId}/cards`: Obtiene la lista de cartas adquiridas por un usuario registrado.

# Listado de Tarjetas Disponibles:
1. `GET /api/v1/cards`: Obtiene la lista de todas las tarjetas disponibles para la venta.
2. `GET /api/v1/cards/{cardCode}`: Obtiene detalles de una carta específica.

# Búsqueda de Item:
1. `GET /api/v1/cards?name=NombreBuscado`: Realiza una búsqueda filtrada por nombre de tarjeta.

# Registro de Tarjeta:
1. `POST /api/v1/payment/methods`: Agrega un método de pago (tarjeta) a la cuenta del usuario.
2. `PUT /api/v1/payment/methods/{paymentMethodId}`: Edita un método de pago existente en la cuenta del usuario.
3. `DELETE /api/v1/payment/methods/{paymentMethodId}`: Elimina un método de pago de la cuenta del usuario.

# Gestión de Subasta con Deadline:
1. `GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards`: Obtiene el estado de la subasta de una tarjeta para un usuario vendedor.
2. WebSocket: `/ws/card-bid/{userId}`: Recibe notificaciones en tiempo real de las ofertas en subastas del usuario.
3. `GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/bids`: Obtiene el historial de ofertas en una subasta.
4. `GET /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/winner`: Obtiene información sobre el ganador de una subasta.
5. `POST /api/v1/auctioning/{auctioningId}/users/{userId}/cards/{cardCode}/closure`: Permite al usuario vendedor cerrar manualmente una subasta.
6. `GET /api/v1/auctioning/users/{userId}/cards/history`: Obtiene el historial de subastas pasadas de un usuario vendedor.

# Soporte de Reclamos:
1. `GET /api/v1/support`: Proporciona acceso al soporte y enlaces a opciones de soporte.
2. `POST /api/v1/support/claims`: Permite a los usuarios presentar reclamos.
3. `GET /api/v1/support/claims/{claimId}`: Permite hacer seguimiento de reclamos existentes.
4. `GET /api/v1/support/users/{userId}/claims/history`: Obtiene el historial de reclamos de un usuario.