# Download and install GitLab Runner
Invoke-WebRequest -Uri https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe -OutFile C:\GitLab-Runner\gitlab-runner.exe
Set-Service -Name gitlab-runner -StartupType 'Manual'
Start-Service -Name gitlab-runner

# Register GitLab Runner with your GitLab instance
# Replace <YOUR_REGISTRATION_TOKEN> with your actual registration token
gitlab-runner register -n --url "https://gitlab.com/" --registration-token "<YOUR_REGISTRATION_TOKEN>" --executor "shell" --description "My Runner"

# Optionally, configure additional Runner settings if needed
# gitlab-runner.exe edit
