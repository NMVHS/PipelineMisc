@echo off

::user input vars
set HOUDINI_MAJOR_VERSION=%1
set REDSHIFT_VERSION=%2
set USE_HYTHON=%3

set RESTVAR=
shift
:loop1
if "%3"=="" goto after_loop
set RESTVAR=%RESTVAR% %3
shift
goto loop1

:after_loop
echo %RESTVAR%

::figure out houdini version
set SIDEFX_APP_DIR=C:\Program Files\Side Effects Software

IF %HOUDINI_MAJOR_VERSION%==17.5 goto H17.5

:H17.5
FOR %%G IN (17.5.258,17.5.173) DO (
  echo %%G
  IF EXIST "%SIDEFX_APP_DIR%\Houdini %%G\"  (
    set HOUDINI_VERSION=%%G
    goto keepgoing
  )
)
goto :eof

:keepgoing
set PIPELINE_HOUDINI_COMMON=Z:\System\Pipeline\apps\houdini\common
set PIPELINE_REDSHIFT_COMMON=Z:\System\Programs\Redshift
set HYTHON_LAUNCHER_PATH=Z:\System\Launchers\Houdini\Configs\Houdini_Rs_Launcher.bat
set HYTHON_LAUNCHER_ARGS=%HOUDINI_MAJOR_VERSION% %REDSHIFT_VERSION% 1

::Set up Redshift paths
set REDSHIFT_COREDATAPATH=%PIPELINE_REDSHIFT_COMMON%\redshift_v%REDSHIFT_VERSION%
set REDSHIFT_LOCALDATAPATH=C:\ProgramData\Redshift
set REDSHIFT_PROCEDURALSPATH=%REDSHIFT_COREDATAPATH%\Procedurals
set REDSHIFT_PREFSPATH=%REDSHIFT_LOCALDATAPATH%\preferences.xml
set REDSHIFT_LICENSEPATH=%REDSHIFT_LOCALDATAPATH%

::set houdini env vars
set "HOUDINI_DSO_ERROR=2"
set "HOUDINI_PATH=$REDSHIFT_COREDATAPATH/Plugins/Houdini/%HOUDINI_VERSION%;%PIPELINE_HOUDINI_COMMON%\deadline_submitters;&"
set "HOUDINI_MENU_PATH=%PIPELINE_HOUDINI_COMMON%\deadline_submitters;&"
set PATH=%REDSHIFT_COREDATAPATH%/bin;%PATH%
set "HOUDINI_ACCESS_METHOD=2"

set QLIB=Z:\System\Pipeline\apps\houdini\common\tools\qLib-master\otls
set "HOUDINI_OTLSCAN_PATH=@/otls;$QLIB/base;$QLIB/future;$QLIB/experimental"


if %USE_HYTHON%==1 (start /b /wait "" "C:\Program Files\Side Effects Software\Houdini %HOUDINI_VERSION%\bin\Hython.exe" %RESTVAR% ) else ("C:\Program Files\Side Effects Software\Houdini %HOUDINI_VERSION%\bin\houdinifx.exe")

