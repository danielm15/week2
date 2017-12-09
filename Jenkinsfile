node {
    checkout scm
    agent {
        docker {
            image 'danielm15/week2:${BUILD_TAG}'
            args '-u root:sudo -v $HOME/workspace/TicTacToe'
        }
    }
    stage('Build') {
        echo 'Building..'
/*
        dir('provisioning') {
            sh './docker-instance-init.sh'
        }
*/
        sh 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'
        sh 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'
        sh 'apt remove cmdtest -y && apt-get update -y && apt-get install yarn'
        sh 'yum -y update'
        sh 'yum -y remove java-1.7.0-openjdk'
        sh 'yum -y install java-1.8.0'
        sh 'yum -y install docker'
        sh 'pip install docker-compose'
        sh 'pip install backports.ssl_match_hostname --upgrade'
        sh 'usermod -a -G docker ec2-user'
        sh 'yum install -y ecs-init'
        sh 'gpasswd -a jenkins docker'
        sh 'service docker start'
        sh 'chkconfig docker on'
        sh 'yum install git -y'

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
