# Historia de Usuario #10: Ingreso de Usuario

### Título: Acceso Seguro al Sistema

**Como** usuario de la plataforma.

**Quiero** poder ingresar de forma segura.

**Para** comprar o vender tarjetas.


## Criterios de Aceptación:

1. **Validación de Credenciales**:  
   - Dado que soy un usuario registrado,
   - Cuando ingreso mi nombre de usuario y contraseña,
   - Entonces el sistema debe verificar la combinación y permitirme el acceso si es correcta.

2. **Notificación de Errores**:  
   - Dado que soy un usuario registrado intentando ingresar,
   - Cuando ingreso una contraseña incorrecta,
   - Entonces debo recibir un mensaje de error claro y la opción de recuperar mi contraseña o reintentar el ingreso.

3. **Seguridad de la Sesión**:  
   - Dado que he ingresado exitosamente,
   - Cuando estoy utilizando la plataforma,
   - Entonces mi sesión debe permanecer activa y segura mediante el uso de un token de sesión.

4. **Cierre de Sesión Automático**:  
   - Dado que estoy inactivo por un período extendido,
   - Cuando el sistema detecta inactividad
   - Entonces debo ser automáticamente deslogueado para proteger mi cuenta.

5. **Recuperación de Contraseña**:  
   - Dado que he olvidado mi contraseña,
   - Cuando elijo la opción de recuperar contraseña,
   - Entonces debo recibir instrucciones vía correo electrónico para establecer una nueva contraseña.

6. **Cifrado de Credenciales**:  
   - Dado que estoy ingresando mi contraseña,
   - Cuando esta se envía al servidor,
   - Entonces debe estar cifrada para asegurar la privacidad y seguridad de mis datos.

7. **Registro de Intentos de Ingreso**:  
   - Dado que un usuario intenta ingresar,
   - Cuando la contraseña es ingresada incorrectamente más de un número permitido de veces,
   - Entonces el sistema debe bloquear temporalmente el acceso y notificar al usuario.

## Analisis

### Pantalla de inicio de la pagina

A continuación se presenta la pantalla de inicio, cuyo funcionamiento es.

1. El usuario entro en la web
2. El usuario deberá presionar Iniciar sesion para comenzar el proceso de autorizacion con auth0

![Mercado publico](/imagenes/Mercado%20Publico.png)

## Diseño Endpoints

#### Pantalla inicial de la web

### 1. Para redireccion a federacion de login

Request:
```http
GET BASE_URL/api/v1/authorization
Accept: application/json
```

Response: Exitoso (Código de estado HTTP: Encontrado)
```json
{
  "url": "URL redireccion a proveedor de login"
}
```

Response: Error de servidor interno (Código de estado HTTP: 500)
```json
{
  "error": "Error por parte del servidor",
  "error_description": "Ocurrió un error inesperado. Por favor, intente nuevamente más tarde."
}
```

### 2. Procesamiento del Callback de Auth0

Request:
```http
POST BASE_URL/api/v1/authorization/callback
Content-Type: application/json
Accept: application/json
{
  "code": "Token de autorizacion"
}
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "accessToken": "Token JWT",
  "refreshToken": "Refresh Token",
  "expiresIn": 3600
}
```

Response: Fallo (Código de estado HTTP: 400)
```
{
  "error": "Fallo de solicitud",
  "error_description": "El codigo de autorización está ausente."
}
```

Response: Error de autorización fallida (Código de estado HTTP: 401)
```
{
  "error": "No autorizado",
  "error_description": "El código de autorización es inválido o ha expirado. Por favor, vuelva a iniciar sesion."
}
```

### 3. Para refrescar el token JWT

Request:
```http
POST BASE_URL/api/v1/authorization/refresh
Content-Type: application/json
Accept: application/json
{
  "refreshToken": "Refresh Token Actual"
}
```

Response: Exitoso (Código de estado HTTP: 200)

```json
{
  "accessToken": "Nuevo token de autorizacion",
  "expiresIn": 3600
}
```

Response: Error de autorización fallida (Código de estado HTTP: 401)
```json
{
  "error": "No autorizado",
  "error_description": "El refresh token es inválido o ha expirado. Por favor, inicie sesión nuevamente."
}
```