---
applyTo: "**"
---

# Instrucciones para generación de mensajes de commit

- Los mensajes de commit deben seguir estrictamente el estándar [Conventional Commits](https://www.conventionalcommits.org/).
- Incluye siempre un emoji relevante al tipo de commit al inicio del mensaje (por ejemplo: ✨, 🐛, ♻️, 🚀, 📝, 🔥, 🚑️, ⬆️, ⬇️, etc).
- El mensaje debe tener el siguiente formato:
  ```
  <emoji> <type>[optional scope]: <short summary>
  
  <detailed description explaining what, why and how>
  ```
- Usa los tipos estándar: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- El resumen debe ser breve (máx. 72 caracteres), en minúsculas y sin punto final.
- La descripción debe ser detallada, explicando claramente qué se hizo, por qué y cómo.
- Si aplica, incluye referencias a issues o tareas relacionadas.
- Ejemplo:
  ```
  ✨ feat(auth): añade soporte para login con YubiKey

  Se implementa la autenticación usando YubiKey para mejorar la seguridad. 
  Se actualizan los controladores y se agregan pruebas unitarias. Relacionado con #42.
  ```

# Instrucciones adicionales para generación de mensajes de commit

- Siempre que sea posible, referencia issues, tareas o tickets relacionados usando el formato estándar (por ejemplo: `Relacionado con #123` o `Refs #123`).
- Si el proyecto lo requiere, escribe los mensajes de commit en inglés o español según el idioma predominante del repositorio.
- Evita mensajes genéricos como "update", "fix bug" o "minor changes". Sé específico sobre el cambio realizado.
- Si el commit introduce breaking changes, indícalo claramente en la descripción usando la sección `BREAKING CHANGE:` y explica el impacto.
- Para cambios que afectan la seguridad, usa el tipo `fix` y describe el riesgo mitigado.
- Si el commit es resultado de un merge o revert, usa los tipos `merge` o `revert` y explica el contexto.
- Para refactorizaciones sin cambio de funcionalidad, usa `refactor` y explica la motivación.
- Si el commit solo actualiza dependencias, usa `chore(deps)` y especifica los paquetes afectados.
- Ejemplos adicionales:
  ```
  🐛 fix(api): corrige error de validación en endpoint de usuarios

  Se soluciona un problema donde la validación de emails permitía valores inválidos.
  Relacionado con #56.
  ```

  ```
  ♻️ refactor(core): simplifica lógica de manejo de errores

  Se reorganiza el flujo de control para mejorar la legibilidad y facilitar futuras extensiones.
  No se modifica la funcionalidad existente.
  ```

  ```
  🚨 fix(security): actualiza dependencia vulnerable

  Se actualiza express de 4.17.1 a 4.18.2 para mitigar vulnerabilidad CVE-2022-12345.
  ```

  ```
  ⚠️ feat(config): añade soporte para múltiples entornos

  Se permite configurar variables de entorno para desarrollo, pruebas y producción.
  BREAKING CHANGE: la configuración previa en config.js ya no es compatible.
  ```
