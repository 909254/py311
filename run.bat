@echo off
setlocal

cd /d "%~dp0\..\.." || exit /b 1

set "IMAGE_NAME=biaoshen-py311:latest"
if not "%~1"=="" set "IMAGE_NAME=%~1"

if not exist "web_data" mkdir "web_data"

set "ENV_ARGS="
if exist ".env" set "ENV_ARGS=--env-file .env"

docker run --rm --name biaoshen-py311 -p 8000:8000 %ENV_ARGS% -e WEB_PORT=8000 -e BID_REVIEW_PAGE_RENDERER=libreoffice -e BID_REVIEW_LIBREOFFICE_PATH=/usr/bin/libreoffice --mount "type=bind,source=%CD%\web_data,target=/app/web_data" "%IMAGE_NAME%"
set "EXIT_CODE=%errorlevel%"

endlocal & exit /b %EXIT_CODE%
