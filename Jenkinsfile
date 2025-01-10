pipeline {
    agent any
    environment {
        PROJECT_DIR = 'Neighborhood' 
    }
    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir() 
            }
        }
        stage('Clone Project') {
            steps {
                sshagent(['github-ssh-key']) {
                    sh "git clone git@github.com:antonBezlyudnyy/${PROJECT_DIR}.git"
                }
            }
        }
        stage('Verify Project') {
            steps {
                sh "ls -al ${PROJECT_DIR}" // Verifies the cloned project
            }
        }
        stage('Build') {
            steps {
                sh "xcodebuild -project ${PROJECT_DIR}/Neighborhood.xcodeproj -scheme Neighborhood -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 16' CODE_SIGN_IDENTITY='iPhone Developer' clean build"
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh "xcodebuild test -project ${PROJECT_DIR}/Neighborhood.xcodeproj -scheme NeighborhoodTests -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 16' CODE_SIGN_IDENTITY='iPhone Developer'"
            }
        }
        stage('Run UI Tests') {
            steps {
                sh "xcodebuild test -project ${PROJECT_DIR}/Neighborhood.xcodeproj -scheme NeighborhoodUITests -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 16' CODE_SIGN_IDENTITY='iPhone Developer'"
            }
        }
    }
}