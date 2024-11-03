@echo off

set REPO_URL=https://github.com/emajesty/ssgoat.git
set BUILD_DIR=.\build

echo Hell world

where cargo >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Cargo not found
    call :install_rust
)

cargo install --git %REPO_URL%

if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%"
)

mkdir "%BUILD_DIR%"

ssgoat . "%BUILD_DIR%"

exit /b 0

:install_rust
echo Installing Rust
curl --proto =https --tlsv1.2 -sSf https://win.rustup.rs -o rustup-init.exe
rustup-init.exe -y
set PATH=%PATH%;%USERPROFILE%\.cargo\bin
exit /b 0

