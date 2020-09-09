pipeline {
//options { timestamps () }
  environment {
    registry = "bds1959/murali_gameoflife"
    registryCredential = 'git-docker'
    dockerImage = ''
  }
    // some block
    agent {
        label "master"
    }
    tools {
        // Note: this should match with the tool name configured in your jenkins instance (JENKINS_URL/configureTools/)
        maven "MAVEN_HOME"
    }
  stages {
    stage('Cloning Git') {
            steps {
                    git credentialsId: 'git-docker', url: 'https://github.com/bds1959/murali_gameoflife.git'
                    //git credentialsId: '720dd959-df22-4b2b-a557-34d49158925c', url: 'https://github.com/bds1965/game-of-life.git'
                }
    }
    stage("mvn build") {
            steps {
                script {
                    // Since unit testing is out of the scope we skip them
                    sh "mvn package -DskipTests=true"
                }
            }
    }
    stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
    }
    stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
    }
stage('uploading cookbook to chef server') {
            steps{
                script {
                    //sshagent(['168-server']) {
                    //    sh "ssh -o StrickHostKeyChecking=no bds3@bds3-Devops ansible-playbook /home/bds3/docker_project/demo.yml"
                    //sshPublisher(publishers: [sshPublisherDesc(configName: 'bds3@bds3-Devops', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /home/bds3/docker_project/demo.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                 
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'devopscitool@172.16.1.168', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'cd chef-repo/cookbooks; knife cookbook upload murali_gameoflife', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)]) 
                } 
            }
    }
}
}
