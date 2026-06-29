from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)

# Expone métricas para Prometheus
metrics = PrometheusMetrics(app)

# Endpoint principal
@app.route('/')
def hello():
    return "¡¡¡¡   Hola Mundo   !!!!"

# Endpoint de prueba
@app.route('/ping')
def ping():
    return "pong"

if __name__ == '__main__':
    # La app corre en el puerto 5000
    app.run(host='0.0.0.0', port=5000)
