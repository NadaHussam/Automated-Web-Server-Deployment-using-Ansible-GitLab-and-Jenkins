pipeline {
    agent any
    stages {
        stage('test'){
            steps{
                script{
                    sh "echo 'hello'"
                }
            }
        }
        stage('Deploy Bash Script to Server') {
            steps {
                script {
                    sshagent(['ssh_key']) {
                        // SSH commands to connect to remote server and execute tasks
                        sh "ssh -o StrictHostKeyChecking=no root@192.168.86.145 'echo Hello from Jenkins'"
                        sh "scp -o StrictHostKeyChecking=no GroupMembers.sh root@192.168.86.145:/root"
                        sh "ssh -o StrictHostKeyChecking=no root@192.168.86.145 'sudo chmod +x /root/GroupMembers.sh'"
                        sh "ssh -o StrictHostKeyChecking=no root@192.168.86.145 '/root/GroupMembers.sh' > file.txt" 
                    }
                }
            }
        }
        stage('Install Apache using Ansible playbook') {
            steps {
                script {
                    sshagent(['ssh_key']) {
                        sh "anssible-playbook -i hosts WebServerSetup.yml"
                    }
                }
            }
        }
    } 
    post {
    
      failure {
        script {
            def failedReason = currentBuild.currentResult.toString()
            def date = new Date().format('yyyy-MM-dd')
            def webAdmins = sh(returnStdout: true, script: "cat file.txt")
            // Email Configuration (Replace with your details)
            def recipientEmail = 'nadahussameldien@gmail.com'
            def subject = "Jenkins Pipeline Failure - Web Server Setup (VM3)"

            emailext body: "Reason : ${failedReason} \nUsers : \n${webAdmins} \nDate : ${date}",
            mimeType: 'text/plain',
            subject: subject,
            to: recipientEmail,
            replyTo: recipientEmail,
            // Consider using CulpritsRecipientProvider after proper configuration (refer to plugin documentation)
            recipientProviders: [[$class: 'CulpritsRecipientProvider']]
            
        }
      }
  }
}
