# Historia de Usuario #50: Soporte

### Título: Soporte de reclamos

**Como** usuario de la plataforma.

**Quiero** poder hacer un reclamo sobre una subasta.

**Para** poder resolver problemas que haya tenido con una transacción o con otro usuario.


## Criterios de Aceptación:

1. **Acceso Fácil al Soporte**:
   - Dado que soy un usuario con una inquietud o problema.
   - Cuando necesito asistencia.
   - Entonces debo poder encontrar y acceder fácilmente a las opciones de soporte desde cualquier página de la plataforma.

2. **Formulario de Reclamos**:
   - Dado que tengo un problema específico con una subasta.
   - Cuando decido hacer un reclamo.
   - Entonces quiero disponer de un formulario claro y sencillo para describir el problema y enviar mi reclamo.

3. **Confirmación de Recepción**:
   - Dado que he enviado un reclamo.
   - Cuando el sistema lo reciba.
   - Entonces espero obtener una confirmación inmediata de que mi reclamo ha sido registrado, con un número de seguimiento asignado.

4. **Seguimiento de Reclamos**:
   - Dado que he presentado un reclamo,
   - Cuando quiero saber el estado del mismo,
   - Entonces debo poder hacer seguimiento a través de la plataforma utilizando mi número de seguimiento.

7. **Historial de Reclamos**:
   - Dado que podría tener más de un reclamo.
   - Cuando reviso mi perfil de usuario.
   - Entonces quiero tener acceso a un historial de todos mis reclamos anteriores y su estado actual o final.

## Analisis

### Pantalla de reclamo

A continuación se presenta la pantalla de reclamo, cuyo funcionamiento es.

1. El usuario inicia sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona una subasta especifica
4. Si el usuario ve algo que le incomoda presiona Hacer reclamo

![Crear subasta](/imagenes/Crear%20Reclamo.png)

### Pantalla detalle reclamo

A continuación se presenta la pantalla de detalle reclamo, cuyo funcionamiento es.

1. El usuario inicia sesion en la pagina web.
2. El usuario es redirigido a la pagina con las subastas en curso
3. El usuario presiona Mis Reclamos
4. El usuario presiona Ver detalle de un reclamo

![Crear subasta](/imagenes/Reclamos.png)

## Diseño Endpoints

#### Pantalla de "Mis reclamos" 

### 1. **Acceso Fácil al Soporte**

Request
```http
GET /api/v1/support
Accept: application/json
```

Response: Exito (Código de estado HTTP: 200)
```json
{
  "supportLink": "/support/submit/claim",
  "faqLink": "/support/faq",
  "liveChat": "/support/live/chat"
}
```
Response: No disponible (Código de estado HTTP: 503)
```json
{
  "error": "El servicio de soporte no está disponible en este momento. Por favor, inténtelo más tarde."
}
```

### 2. **Formulario de Reclamos**

Request
```http
POST /api/v1/support/claims
Accept: application/json
Authorization: Bearer {JWT}
Content-Type: application/json

{
  "auctioningId": "Codigo de subasta",
  "issueType": "Problema de descripcion",
  "description": "El item es diferente a lo descrito"
}
```

Response: Exito (Código de estado HTTP: 200)
```json
{
  "claimId": "Codigo de reclamo",
  "status": "Recibido",
  "message": "Su reclamo ha sido registrado con éxito. Use el ID de reclamo para seguimiento."
}
```

Response: Datos incompletos (Código de estado HTTP: 400)
```json
{
  "error": "La información proporcionada para el reclamo esta incompleta."
}
```

### 3. **Seguimiento de Reclamos**

Request
```http
GET /api/v1/support/claims/{claimId}
Accept: application/json
Authorization: Bearer {JWT}
```

Response: Exito (Código de estado HTTP: 200)
```json
{
  "claimId": "Id reclamo",
  "status": "En Proceso",
  "details": "Su reclamo está siendo revisado por nuestro equipo de soporte."
}
```

Response: Reclamo no encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No se encontró un reclamo con el ID proporcionado."
}
```

### 4. Historial de Reclamos

**Endpoint para obtener historial de reclamos del usuario:**
```http
GET /api/v1/support/users/{userId}/claims/history
Accept: application/json
Authorization: Bearer {JWT}
```

Response: Exito (Código de estado HTTP: 200)
```json
[
  {
    "claimId": "Id reclamo",
    "auctioningId": "Id subasta",
    "issueType": "Problema de descripcion",
    "status": "Resuelto",
    "submissionDate": "2023-11-03T10:00:00Z",
    "resolutionDate": "2023-11-10T15:00:00Z"
  },
  // ... otros reclamos
]
```

Response: Historial no encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No se encontró historial de reclamos para este usuario."
}
```

Response: No autorizado (Código de estado HTTP: 401)
```json
{
  "error": "No autorizado. Debe iniciar sesión para acceder al historial de reclamos."
}
```
