pipeline {
    checkout scm
    agent {
        docker {
            image 'node:6.9.1'
        }
    }
    stage('Build') {
        echo 'Building..'

        sh 'npm run startpostgres && sleep 10 && npm run migratedb'
        sh 'npm run build'
        sh './dockerbuild.sh'
    }
    stage('Test') {
        echo 'Testing..'

        sh 'npm run startserver'
        sh 'echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p'
        sh 'npm run test'
        sh 'npm run apitest'
        sh 'npm run loadtest'
    }
    stage('Deploy') {
        echo 'Deploying....'

        dir('provisioning') {
            sh './provision-new-environment.sh'
        }
    }
}
