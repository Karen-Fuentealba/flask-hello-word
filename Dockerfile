# Imagen base ligera de Python
FROM python:3.11-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copio primero las dependencias
COPY requirements.txt .

# Instalo dependencias con mensajes
RUN echo "Instalando dependencias desde requirements.txt..." && \
    pip install --no-cache-dir -r requirements.txt

# Copio el resto del código
COPY . .

# Expongo el puerto de Flask
EXPOSE 5000

# Mensaje antes de ejecutar la aplicación
CMD echo "Iniciando aplicación Flask en contenedor..." && python webapp.py
