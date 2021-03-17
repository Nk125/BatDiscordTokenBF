@echo off
setlocal enableextensions enabledelayedexpansion
:: Sirve para checkear tokens individualmente
:main
echo ====================
echo ^|   NK125 Discord  ^|
echo ^|   Token Checker  ^|
echo ====================
echo.
:enter
echo.
set /p "token=Ingresa el token a comprobar: "
echo %token% | findstr /I /C:""">token
if exist token (
      del token /f /s /q
      cls
      goto main
)
if "%token%"=="" goto enter
echo.
echo Haciendo request para comprobar token, espere por favor. . .
echo.
echo Authorization:%token%>header
echo Content-Type:application/json>>header
call winhttpjs.bat https://discordapp.com/api/v6/users/@me -method GET -headers-file header -saveTo response.txt -force yes | findstr /I /C:"Status: 200"
if %errorlevel% GEQ 1 (
      echo Token Invalido
      del header /f /s /q 1>nul 2>nul
      for /f "tokens=2 delims=:," %%a in (response.txt) do for /f "tokens=3 delims=:," %%b in (response.txt) do (
            echo Respuesta:%%a%%b
      )
      del response.txt /f /s /q 1>nul 2>nul
      goto enter
)
del header /f /s /q 1>nul 2>nul
for /f "tokens=22 delims=,:" %%a in (response.txt) do (
      echo.
      echo La cuenta esta verificada:%%a
)
for /f "tokens=6 delims=,:" %%a in (response.txt) do (
      echo.
      echo Avatar:%%a
)
for /f "tokens=10 delims=,:" %%a in (response.txt) do (
      echo.
      echo Flags Publicos:%%a
)
for /f "tokens=16 delims=,:" %%a in (response.txt) do (
      echo.
      echo NSFW Habilitado:%%a
)
for /f "tokens=2 delims=,:" %%a in (response.txt) do (
      echo.
      echo ID:%%a
)
for /f "tokens=4 delims=,:" %%a in (response.txt) do (
      echo.
      echo Nombre de usuario:%%a
)
for /f "tokens=8 delims=,:" %%a in (response.txt) do (
      echo.
      echo Discriminador:%%a
)
for /f "tokens=20 delims=,:" %%a in (response.txt) do (
      echo.
      echo Email:%%a
)
for /f "tokens=24 delims=,:}" %%a in (response.txt) do (
      echo.
      echo Numero de telefono:%%a
)
for /f "tokens=18 delims=,:" %%a in (response.txt) do (
      echo.
      echo Tiene Multi Factor Authentication (Numero de telefono, 2FA^):%%a
)
for /f "tokens=14 delims=,:" %%a in (response.txt) do (
      echo.
      echo Idioma:%%a
)
del response.txt /f /s /q > nul
pause
goto main
