# Automated Web Server Deployment with CI/CD Pipeline GitHub:
This project demonstrates an on-premise CI/CD pipeline for deploying a web server with Apache HTTP Server. It involves provisioning virtual machines, user management, GitLab and Jenkins integration, and automated deployment upon code changes.

### Project Goals
* Automate web server deployment using a CI/CD pipeline.
* Streamline development workflows with GitLab and Jenkins integration.
* Implement user management and access control for the web server.
* Improve deployment reliability and reduce manual intervention.

### Components
* **Three VMs (On-Premise):**
    * VM1: Jenkins Server (for CI/CD orchestration)
    * VM2: GitLab Server (for code repository hosting)
    * VM3: Web Server (running Apache HTTP Server)
* **User Management:**
    * Users ("DevTeam" and "OpsTeam") created on VM3.
    * Users assigned to the "webAdmins" group for centralized access control.
* **CI/CD Pipeline:**
    * GitLab repository for hosting project code.
    * Jenkins pipeline triggered by code changes.
    * Automated deployment steps:
        - Deploy Bash script (CreateUsers.sh) to VM3 for user creation.
        - Execute Ansible playbook (WebServerSetup.yml) to install and configure Apache on VM3.
        - Generate email notification upon pipeline failures (failure reason, user list, date).

### Benefits
* Increased automation and efficiency in deployment processes.
* Reduced manual effort and improved consistency in deployments.
* Centralized control over user access and permissions for the web server.
* Faster feedback loop through automated deployment triggered by code changes.


### Getting Started
1. **Provision VMs:** Set up three virtual machines (Jenkins, GitLab, Web Server) on your chosen platform (e.g., VirtualBox, VMware).
2. **Install Software:** Install required software on each VM:
    * Jenkins server: Jenkins
    * GitLab server: GitLab (or similar Git hosting platform)
    * Web server: Operating system (e.g., CentOS, Rocky Linux), Apache HTTP Server
3. **Configure User Management:** Create users and assign them to the "webAdmins" group on the web server using the provided Bash script (CreateUsers.sh).
4. **Integrate GitLab & Jenkins:**
   To facilitate communication between GitLab and Jenkins and to trigger builds upon code changes, follow these steps to configure the webhook:
   #### Jenkins Configuration:
   1. **Disable CSRF Protection**:
      - Navigate to **Manage Jenkins** > **Configure Global Security**.
      - Uncheck the option **Prevent Cross Site Request Forgery exploits**.
   2. **Configure Job (Project)**:
      - Go to the job configuration page by clicking on the job name and then **Configure**.
      - Scroll down to the **Build Triggers** section.
      - Check the option **Build when a change is pushed to GitLab**.
      - In the **GitLab webhook URL** field, enter `http://192.168.86.143:8080/project/project1`.
      - Click on **Advanced...** and then **Generate** to create a secret token. Take note of this token as it will be used in the GitLab webhook configuration.
   #### GitLab Webhook Configuration:
   1. **Set Webhook URL**:
      - In your GitLab project, navigate to **Settings** > **Webhooks**.
      - In the **URL** field, enter `http://192.168.86.143:8080/project/project1`.
   2. **Enter Secret Token**:
      - In the **Secret Token** field, paste the token generated from Jenkins.
   3. **Select Triggers**:
      - Choose the events that should trigger the webhook, such as **Push events** or **Merge request events**.
   4. **Add Webhook**:
      - Click on **Add webhook** to save the configuration.
   By completing these steps, you have configured GitLab to send webhook notifications to Jenkins, which will trigger a build when changes are pushed to your GitLab repository.

6. **Develop CI/CD Pipeline:** Create a Jenkinsfile defining the pipeline stages for script deployment, Ansible playbook execution, and email notification generation.
7. **Test and Refine:** Test the pipeline functionality and refine configurations as needed to ensure smooth deployment automation.

### Additional Notes
* Security considerations: Implement best practices for securing your VMs, credentials, and access controls.
* Consider using environment variables or secrets management tools for sensitive information.
* Explore advanced features of Jenkins and plugins (e.g., email notification customization, pipeline branching strategies).
