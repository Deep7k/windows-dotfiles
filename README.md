# Windows Dotfiles

Welcome to my Windows dotfiles repository. This repository contains my personal configuration files and scripts for setting up a Windows environment. These dotfiles are managed using PowerShell.

## Table of Contents

- [Installation](#installation)
- [Features](#features)
- [Usage](#usage)
- [Setup Script Parameters](#setup-script-parameters)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Credits](#credits)
- [License](#license)

## Installation

### Prerequisites

Before you can use these dotfiles, ensure you have the following installed:

- [Git](https://git-scm.com/)
- [PowerShell 7+](https://github.com/PowerShell/PowerShell)

### Steps

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Deep7k/windows-dotfiles.git "$env:USERPROFILE\.dotfiles"
   cd ~\.dotfiles
   ```

2. **Run the setup script:**
   ```sh
   .\setup.ps1
   ```

This will install additional dependencies, installs required fonts and configures Oh-My-Posh shell prompt.

## Features

- **PowerShell Profile:** Custom PowerShell profile with aliases, functions.
- **Oh-My-Posh prompt:** Beautiful prompt that has git integration
- **windows terminal settings:** My windows terminal settings

## Usage

### PowerShell

After running the setup script, you can start using the customized PowerShell environment. Some features include:

- **Aliases:** Shortcut commands for common tasks.
- **Functions:** Reusable PowerShell functions.
- **Custom Prompt:** Enhanced prompt with Git branch information.

### Windows Terminal 

Includes custom color scheme

## Setup Script Parameters

The `setup.ps1` script supports various parameters to customize its behavior. Here are the available parameters:

### `-WithOptionalFont`

Installs FiraCode Nerd Font. which is my go to font for text editors.

**Usage:**
```sh
.\setup.ps1 -WithOptionalFont
```

### `-WithOptionalApps`

Installs some of the essential apps that I use daily.

**Usage:**
```sh
.\setup.ps1 -WithOptionalApps
```


You can combine multiple parameters as needed. For example:
```sh
.\setup.ps1 -WithOptionalFont -WithOptionalApps
```

## Customization

Feel free to customize these dotfiles to suit your needs. Here are some common customization options:

- **PowerShell Profile:** Edit `Powershell\Microsoft.PowerShell_profile.ps1` to add or modify aliases, functions, and other settings.
- **Windows Terminal Settings:** Modify `windows-terminal-settings.json` to tweak Vim settings and plugins.
- **optional apps:** Update `optional-apps.json` with your preferred your apps list.

## Troubleshooting

If you encounter any issues, here are some common solutions:

- **PowerShell Execution Policy:** You may need to set the execution policy to allow running scripts:
  ```sh
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  Unblock-File .\setup.ps1
  ```

## Contributing

Contributions are welcome! If you have improvements or fixes, feel free to submit a pull request. Please ensure your contributions adhere to the following guidelines:

- Follow the existing coding style.
- Test your changes thoroughly.
- Update the documentation if necessary.

## Credits

This project was inspired by the following resources and people:

- [Chris Titus Tech](https://christitus.com/the-ultimate-powershell-experience/) for inspiring me to create this repo.
- [jandedobbeleer](https://github.com/jandedobbeleer/) for creating awesome app to customize powershell prompt.
- [ryanosis](https://github.com/ryanoasis) for creating beautiful fonts

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.