# CI/CD Deployment to Tomcat with GitHub Actions

This project uses GitHub Actions to automatically deploy site files to an EC2 instance running Tomcat.

## 🚀 Workflow Steps

1. **Checkout code**
   - Uses `actions/checkout@v3` to pull the repository into the GitHub runner.

2. **Prepare SSH key**
   - Saves the private key from GitHub Secrets into `key.pem` and sets correct permissions.

3. **Upload files to EC2**
   - Copies `index.html` and `style.css` from the repo to the EC2 instance using `scp`.

4. **Deploy to Tomcat**
   - On EC2, moves files into `/opt/tomcat/webapps/openedition/`.
   - Restarts Tomcat using `shutdown.sh` and `startup.sh`.

5. **Secrets required**
   - `VM_HOST` → EC2 public IP/DNS
   - `VM_USER` → SSH username (e.g., `ec2-user`)
   - `VM_SSH_KEY` → Private SSH key for authentication

## ✅ Usage

- Push changes to the `main` branch.
- GitHub Actions will run automatically.
- Visit `http://<VM_HOST>:8080/openedition/index.html` to see the deployed site.

