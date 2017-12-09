node {
    checkout scm
    stage('Build') {
        echo 'Building..'
/*
        dir('provisioning') {
            sh './docker-instance-init.sh'
        }
*/
        dir('client') {
            sh 'npm install'
        }
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
