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
