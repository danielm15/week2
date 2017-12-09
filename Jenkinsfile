pipeline {
    agent {
        dockerfile true
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'yum -y install docker'
                sh 'pip install docker-compose'
                sh 'pip install backports.ssl_match-hostname --upgrade'
                sh 'npm run startpostgres && sleep 10 && npm run migratedb'
                sh 'npm run build'
                sh './dockerbuild.sh'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'

                sh 'npm run startserver'
                sh 'echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p'
                sh 'npm run test'
                sh 'npm run apitest'
                sh 'npm run loadtest'                   
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'

                dir('provisioning') {
                    sh './provision-new-environment.sh'
                }
            }
        }
    }
}
