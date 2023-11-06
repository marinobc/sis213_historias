# Whislist

## Historia de Usuario #45: Metodo de pago tarjeta

### Título: Registro de tarjeta

**Como** usuario comprador de la plataforma.

**Quiero** poder registrar mi tarjeta.

**Para** poder comprar tarjetas o participar en pujas de subasta.


## Criterios de Aceptación:

1. **Interfaz de Registro Seguro**:
   - Dado que soy un usuario que desea realizar compras o pujas,
   - Cuando accedo a la opción de agregar un método de pago,
   - Entonces quiero que se me presente una interfaz segura donde pueda ingresar los detalles de mi tarjeta.

2. **Validación de Datos de la Tarjeta**:
   - Dado que estoy ingresando la información de mi tarjeta de crédito o débito,
   - Cuando envío los datos de mi tarjeta,
   - Entonces el sistema debe validarlos para asegurar que son correctos y válidos para transacciones.

3. **Confirmación de Método de Pago Añadido**:
   - Dado que he ingresado los detalles de mi tarjeta correctamente,
   - Cuando el sistema acepta mi tarjeta,
   - Entonces espero recibir una confirmación de que el método de pago ha sido añadido exitosamente a mi cuenta.

4. **Opción de Editar o Eliminar**:
   - Dado que puedo cambiar mi método de pago en el futuro,
   - Cuando necesite actualizar o eliminar una tarjeta guardada,
   - Entonces debo poder hacerlo fácilmente a través de la configuración de mi cuenta.

5. **Autorización de Transacciones**:
   - Dado que voy a realizar compras.
   - Cuando se procese una transacción.
   - Entonces espero que se requiera mi autorización, antes de finalizar la compra.

6. **Proceso de Verificación**:
    - Dado que he registrado una nueva tarjeta,
    - Cuando se añade por primera vez,
    - Entonces puede ser necesario un pequeño cargo de verificación (que luego será reembolsado) para confirmar que la tarjeta es válida.


## Diseño Endpoints

#### Pantalla de registro de tarjeta

### 1. **Para añadir un método de pago (tarjeta):**

Request:
```http
POST /api/v1/payment/methods
Content-Type: Application/json
Authorization: Bearer JWT
```

```json
{
  "cardNumber": "Numero de tarjeta",
  "expiryDate": "Fecha de expiracion",
  "cvv": "Codigo cvv",
  "cardholderName": "Nombre del propietario de la tarjeta"
}
```

Response: Exitoso (Código de estado HTTP: 201)
```json
{
  "message": "Método de pago añadido con éxito.",
  "paymentMethodId": "Codigo identificador del metodo de pago"
}
```
Response: Error de Validación de Datos (Código de estado HTTP: 400)
```json
{
  "error": "Error de valicacion.",
  "message": "Información de la tarjeta inválida o incompleta."
}
```

### 2. **Para editar un método de pago (tarjeta):**

Request:
```http
PUT /api/v1/payment/methods/{paymentMethodId}
Content-Type: Application/json
Authorization: Bearer JWT
```

```json
{
  "cardNumber": "Numero de tarjeta",
  "expiryDate": "Fecha de expiracion",
  "cvv": "Codigo cvv",
  "cardholderName": "Nombre del propietario de la tarjeta"
}
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "message": "Método de pago actualizado con éxito."
}
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "Método de pago no encontrado."
}
```

### 3. **API para eliminar un método de pago (tarjeta):**

Request:
```http
DELETE /api/v1/payment/methods/{paymentMethodId}
Authorization: Bearer JWT
```

Response: Exitoso (Código de estado HTTP: 200)
```json
{
  "message": "Método de pago eliminado con éxito."
}
```

Response: Error de No Encontrado (Código de estado HTTP: 404)
```json
{
  "error": "No encontrado",
  "message": "Método de pago no encontrado."
}
```