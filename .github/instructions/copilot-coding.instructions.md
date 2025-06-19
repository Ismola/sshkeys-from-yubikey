---
applyTo: "**"
---

# Instrucciones para generación de código con Copilot

- Prioriza siempre la claridad y legibilidad del código sobre la optimización prematura.
- Añade comentarios explicativos en bloques de lógica compleja o poco intuitiva.
- Usa nombres descriptivos para variables, funciones y clases.
- Sigue las convenciones de estilo y formato del lenguaje y del proyecto (usa linters y formateadores si están disponibles).
- Si el proyecto tiene pruebas, sugiere o añade pruebas unitarias para nuevas funciones o cambios relevantes.
- Prefiere la reutilización de código existente antes de crear duplicados.
- Si usas dependencias externas, justifica su uso y referencia la documentación oficial.
- Para código asíncrono, maneja correctamente los errores y excepciones.
- Si el cambio afecta la seguridad, documenta los riesgos y mitigaciones.
- Si el código es experimental o tiene limitaciones conocidas, indícalo claramente en los comentarios.
- Cuando sea relevante, incluye ejemplos de uso en los comentarios o en la documentación.
- Si el código modifica la API pública, actualiza la documentación correspondiente.
- Usa el idioma predominante del proyecto para los nombres y comentarios.
- Si tienes dudas sobre requisitos o contexto, pide aclaraciones antes de asumir.

## Ejemplo de buenas prácticas

```python
def calcular_area_circulo(radio: float) -> float:
    """
    Calcula el área de un círculo dado su radio.

    Args:
        radio (float): Radio del círculo.

    Returns:
        float: Área calculada.

    Raises:
        ValueError: Si el radio es negativo.
    """
    if radio < 0:
        raise ValueError("El radio no puede ser negativo")
    return math.pi * radio ** 2
```
