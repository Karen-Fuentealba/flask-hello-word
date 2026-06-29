pipeline {
    agent any

    stages {
        stage('1. Clonar Código') {
            steps {
                echo 'Descargando el código más reciente desde GitHub...'
                checkout scm
            }
        }

        stage('2. Desplegar en Contenedor') {
            steps {
                echo 'Iniciando el despliegue interno...'
                sh '''
                    echo "Creando el directorio de despliegue si no existe..."
                    mkdir -p /var/jenkins_home/deploy

                    echo "Limpiando despliegues anteriores..."
                    rm -rf /var/jenkins_home/deploy/*

                    echo "Copiando app.py al directorio de destino..."
                    cp app.py /var/jenkins_home/deploy/

                    echo "Verificando que el archivo existe en la ruta interna:"
                    ls -l /var/jenkins_home/deploy/
                '''
            }
        }

        stage('3. Ejecutar Aplicación') {
            steps {
                echo 'Probando la aplicación desplegada de forma local...'
                // Ejecuta el script de python directamente desde la carpeta de despliegue
                sh 'python3 /var/jenkins_home/deploy/webapp.py'
            }
        }
    }

    post {
        success {
            echo '¡Proceso finalizado! El despliegue en el contenedor fue exitoso.'
        }
    }
}
