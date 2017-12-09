node {
    checkout scm

    stage('Build') {
        echo 'Building..'
/*
        dir('provisioning') {
            sh './docker-instance-init.sh'
        }
*/
        sh 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
        sh 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list'
        sh 'sudo apt remove cmdtest -y && sudo apt-get update && sudo apt-get install yarn'
        sh 'sudo yum -y update'
        sh 'sudo yum -y remove java-1.7.0-openjdk'
        sh 'sudo yum -y install java-1.8.0'
        sh 'sudo yum -y install docker'
        sh 'sudo pip install docker-compose'
        sh 'sudo pip install backports.ssl_match_hostname --upgrade'
        sh 'sudo usermod -a -G docker ec2-user'
        sh 'sudo yum install -y ecs-init'
        sh 'sudo gpasswd -a jenkins docker'
        sh 'sudo service docker start'
        sh 'sudo chkconfig docker on'
        sh 'sudo yum install git -y'

        sh 'yarn install'

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
