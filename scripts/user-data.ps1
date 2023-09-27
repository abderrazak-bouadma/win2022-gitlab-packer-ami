# Install Chocolatey if not already installed
if (!(Test-Path 'C:\ProgramData\chocolatey\chocolateyinstall')) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Refresh the environment variables to make Chocolatey available
refreshenv

# Install GitLab Runner using Chocolatey
choco install gitlab-runner -y

# Install Rust and Cargo using Chocolatey
choco install rust -y

# Add Rust and Cargo bin directories to the PATH
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\Program Files\Rust\bin", [System.EnvironmentVariableTarget]::Machine)

# Optionally, configure additional Runner settings if needed
# gitlab-runner.exe edit
