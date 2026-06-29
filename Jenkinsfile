pipeline {
    agent any

    stages {
        stage('1. Clonar Código') {
            steps {
                echo 'Descargando el código más reciente desde GitHub...'
                checkout scm
            }
        }

        stage('2. Preparar Despliegue') {
            steps {
                echo 'Iniciando el despliegue interno...'
                sh '''
                    echo "Creando el directorio de despliegue si no existe..."
                    mkdir -p /var/jenkins_home/deploy

                    echo "Limpiando despliegues anteriores..."
                    rm -rf /var/jenkins_home/deploy/*

                    echo "Copiando webapp.py al directorio de destino..."
                    cp webapp.py /var/jenkins_home/deploy/

                    echo "Verificando que el archivo existe en la ruta interna:"
                    ls -l /var/jenkins_home/deploy/
                '''
            }
        }

        stage('3. Construir Imagen Docker') {
            steps {
                echo 'Construyendo la nueva imagen Docker de la aplicación...'
                sh '''
                    echo "Detiene y elimina cualquier contenedor anterior para evitar conflictos"
                    echo "Deteniendo contenedor anterior si existe..."
                    docker stop flask-webapp-container || true

                    echo "Eliminando contenedor anterior si existe..."
                    docker rm flask-webapp-container || true

                    echo "Construye la nueva imagen con los cambios recientes"
                    docker build -t flask-webapp ./flask-hello-word
                   '''
            }
        }

        stage('4. Ejecutar Aplicación en Contenedor') {
            steps {
                echo 'Levantando la aplicación Flask en un nuevo contenedor...'
                sh '''
                    echo "Crea y ejecuta el contenedor con la nueva imagen"
                    docker run -d --name flask-webapp-container -p 5000:5000 flask-webapp

                    echo "Contenedor desplegado correctamente. Verificando estado..."
                    docker ps
                '''
            }
        }
    }

    post {
        success {
            echo '¡Proceso finalizado! La aplicación Flask se reconstruyó y desplegó exitosamente en un contenedor nuevo.'
        }
        failure {
            echo 'Hubo un error durante el pipeline. Revisar logs para más detalles.'
        }
    }
}
