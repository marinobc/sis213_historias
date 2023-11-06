# Historia de Usuario #20: Registro de Usuario

### Título: Registro de Usuario

**Como** persona que no es usuario de la plataforma.

**Quiero** registrarme en la plataforma de la forma mas sencilla posible.

**Para** poder ver los precios de las tarjetas.

## Analisis

### Pantalla de inicio de la pagina

A continuación se presenta la pantalla de inicio, cuyo funcionamiento es.

1. El usuario hizo entro en la web
2. El usuario deberá presionar Iniciar sesion para comenzar el proceso de registro con auth0

![Mercado publico](/imagenes/Mercado%20Publico.png)

### Pantalla de detalles de cartas

A continuación se presenta la pantalla detalles de cartas, cuyo funcionamiento es.

1. El usuario hizo click en ver mas
2. Si el usuario desea ver el precio de una carta debera seguir el proceso de registro mediante auth0

![Mercado publico](/imagenes/Subasta%20publica.png)

## Criterios de Aceptación:

1. **Simplicidad en el Formulario de Registro**:
   - Dado que soy una persona que no es usuario de la plataforma.
   - Cuando accedo a la pantalla de registro.
   - Entonces quiero ver un formulario que requiera sólo la información esencial para registrarme.

2. **Validación de Correo Electrónico**:
   - Dado que he introducido mi información en el formulario de registro.
   - Cuando envío el formulario.
   - Entonces debo recibir un correo electrónico de verificación para asegurarme de que soy el propietario de la dirección de correo electrónico proporcionada.

3. **Confirmación de Registro Exitoso**:
   - Dado que he hecho clic en el enlace de verificación en mi correo electrónico.
   - Cuando se verifica mi correo electrónico.
   - Entonces debo ser redirigido a una pantalla de confirmación de registro exitoso y tener la opción de iniciar sesión directamente.

4. **Complejidad de la Contraseña**:
   - Dado que estoy creando una contraseña durante el registro.
   - Cuando ingreso mi contraseña.
   - Entonces debe haber una validación que garantice que mi contraseña cumple con los estándares mínimos de seguridad.


5. **Retroalimentación de Errores en el Formulario**:
   - Dado que he ingresado información incorrecta o incompleta en el formulario de registro.
   - Cuando intento enviar el formulario.
   - Entonces el sistema debe mostrarme mensajes de error claros que indiquen qué campos necesitan corrección.

6. **Registro Exitoso sin Compra**:
   - Dado que me he registrado exitosamente.
   - Cuando inicio sesión por primera vez.
   - Entonces debo ser capaz de ver los precios de las tarjetas sin necesidad de realizar una compra o introducir información de pago.

7. **Confirmación de Edad**:
   - Dado que la plataforma puede tener restricciones de edad.
   - Cuando un usuario nuevo se registra.
   - Entonces se debe pedir confirmación de que tiene la edad mínima requerida para utilizar la plataforma.

## Diseño Endpoints

#### Pantalla inicial de la web

### 1. Para redireccion a federacion de login

Request:
```http
GET BASE_URL/api/v1/authorization/registration
Accept: application/json
```

Response: Encontrado (Código de estado HTTP: 302)
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

### 2. Para callback de registro de auth0

Request:
```http
GET BASE_URL/api/v1/authorization/registration/callback?code={Codigo de autorizacion de auth0}
Accept: application/json
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "message": "Registro exitoso. Por favor verifica tu correo electrónico para activar tu cuenta."
}
```

## Whishlist

**Políticas de Privacidad y Términos de Servicio**:
   - Dado que estoy en la pantalla de registro.
   - Cuando estoy proporcionando mi información.
   - Entonces debo tener la opción de leer y aceptar las Políticas de Privacidad y los Términos de Servicio antes de completar el registro.