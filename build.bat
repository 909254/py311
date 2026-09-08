@echo off
setlocal

cd /d "%~dp0\..\.." || exit /b 1

set "IMAGE_NAME=biaoshen-py311:latest"
if not "%~1"=="" set "IMAGE_NAME=%~1"

echo Building %IMAGE_NAME% ...
docker build --file "docker\py311\Dockerfile" --tag "%IMAGE_NAME%" .
if errorlevel 1 exit /b %errorlevel%

echo Built %IMAGE_NAME% successfully.
endlocal
