# Presença Studio

Estudio de landing pages para negocios locales (Brasil). Cada sitio se entrega a partir de una plantilla por nicho y se personaliza en ~40 minutos.

## Estructura

```
templates/
  bienestar/index.html   ← plantilla madre (referencia para los demás nichos)
  turismo/  salud/  tiendas/
clientes/
  <slug-cliente>/index.html   ← copia de una plantilla, ya personalizada
scripts/                 ← utilidades (copiar plantilla, validar, publicar)
```

## Reglas obligatorias

1. **Stack**: HTML5 semántico + Tailwind CSS por CDN (`https://cdn.tailwindcss.com`). Sin frameworks, sin build, sin npm. Un solo `index.html` por sitio.
2. **Carga rápida**:
   - Sin librerías JS de terceros (nada de jQuery, sliders, animaciones externas).
   - Imágenes con `loading="lazy"` (excepto la del Hero), `width`/`height` definidos y formato WebP cuando sea posible.
   - Máximo una familia tipográfica de Google Fonts con `display=swap` y `preconnect`.
   - Mapas de Google con `loading="lazy"`.
3. **6 bloques modulares**, siempre en este orden y delimitados con comentarios `<!-- ===== BLOQUE N: NOMBRE ===== -->`:
   1. Hero
   2. Beneficios
   3. Servicios
   4. Testimonios
   5. Ubicación
   6. Footer / CTA WhatsApp
   Cada bloque es una `<section>` (el 6 es `<footer>`) independiente con `id` propio; se puede quitar o reordenar sin romper los demás.
4. **Datos centralizados por cliente**: todos los datos del negocio (nombre, textos, teléfono, WhatsApp, dirección, servicios, testimonios, colores, imágenes) viven en el objeto `CLIENTE` al inicio del `index.html`. Nunca hardcodear datos del cliente dentro del markup de los bloques.
5. **Idioma**: todo texto visible para el cliente final va en **portugués de Brasil** (`<html lang="pt-BR">`). Comentarios de código e instrucciones internas pueden ir en español.
6. **Sin chatbots externos**: prohibido incluir widgets o scripts de chatbots de terceros (Tidio, Crisp, Intercom, ManyChat, Zendesk, etc.). El contacto es únicamente vía enlace `https://wa.me/<número>` con mensaje prellenado.
7. **Seguridad (sitio estático en Cloudflare Pages)**:
   - En el `<head>`: `<meta http-equiv="X-Content-Type-Options" content="nosniff">` y `<meta name="referrer" content="strict-origin-when-cross-origin">`.
   - Todo enlace con `target="_blank"` lleva `rel="noopener noreferrer"`.
   - Las URLs de imágenes, vídeos y redes que vienen de `CLIENTE` se validan en el RENDER (`urlSegura`): solo `https://` o rutas relativas limpias; cualquier otra cosa se descarta.
   - Cada sitio de cliente incluye el archivo `_headers` (copia de `templates/_headers`) con `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy` y `Permissions-Policy`. `nuevo-cliente.ps1` lo copia automáticamente; no borrarlo.
8. **Redes sociales en el footer**: la barra inferior del bloque 6 muestra el teléfono y botones circulares con icono SVG de Instagram y Facebook (`CLIENTE.instagram`, `CLIENTE.facebook`: usuario o URL `https://`; vacío = oculto).
9. **Botones**: todos los CTA (Header, Hero, Footer, móvil) son cápsulas `rounded-full`, nunca esquinas rectas. Contenedores de imagen y mapa con `rounded-2xl`. En móvil el header siempre muestra un botón compacto "Agendar" hacia WhatsApp.

## Flujo para un nuevo cliente

1. Clonar la plantilla: `.\scripts\nuevo-cliente.ps1 -Nicho bienestar -Slug nombre-cliente [-Abrir] [-Force]`.
2. Editar solo el objeto `CLIENTE`. Las URLs de Unsplash de las plantillas son de muestra: en la entrega se sustituyen por fotos reales del cliente.
3. Revisar en móvil (375px) y escritorio; verificar que el botón de WhatsApp abre el número correcto.
