@echo off

::user input vars
set MAYA_VERSION=%1
set REDSHIFT_VERSION=%2
set USE_BATCH=%3

set RESTVAR=
shift
:loop1
if "%3"=="" goto after_loop
set RESTVAR=%RESTVAR% %3
shift
goto loop1

:after_loop
echo %RESTVAR%

set PIPELINE_MAYA_COMMON=Z:\System\Pipeline\apps\maya\common
set PIPELINE_REDSHIFT_COMMON=Z:\System\Programs\Redshift
set MAYABATCH_LAUNCHER_PATH=Z:\System\Launchers\Maya\Configs\Maya_Rs_launcher.bat
set MAYABATCH_LAUNCHER_ARGS=%MAYA_VERSION% %REDSHIFT_VERSION% 1
::Z:\System\Launchers\Maya\Configs\MayaBatch_%MAYA_VERSION%_RS_%REDSHIFT_VERSION%.bat

::Set up Maya env vars
set PYTHONPATH=%PYTHONPATH%;%PIPELINE_MAYA_COMMON%\scripts
set MAYA_PLUG_IN_PATH=%MAYA_PLUG_IN_PATH%;%PIPELINE_MAYA_COMMON%\plugins
set MAYA_PRESET_PATH=%MAYA_PRESET_PATH%;%PIPELINE_MAYA_COMMON%\presets
set MAYA_MODULE_PATH=%MAYA_MODULE_PATH%;%PIPELINE_MAYA_COMMON%\modules
set MAYA_SCRIPT_PATH=%MAYA_SCRIPT_PATH%;%PIPELINE_MAYA_COMMON%\scripts
set MAYA_SHELF_PATH=%MAYA_SHELF_PATH%;%PIPELINE_MAYA_COMMON%\shelves

::Set up Redshift paths
set REDSHIFT_COREDATAPATH=%PIPELINE_REDSHIFT_COMMON%\redshift_v%REDSHIFT_VERSION%
set REDSHIFT_LOCALDATAPATH=C:\ProgramData\Redshift
set REDSHIFT_PROCEDURALSPATH=%REDSHIFT_COREDATAPATH%\Procedurals
set REDSHIFT_PREFSPATH=%REDSHIFT_LOCALDATAPATH%\preferences.xml
set REDSHIFT_LICENSEPATH=%REDSHIFT_LOCALDATAPATH%


::Launch Maya now
if %USE_BATCH%==1 (start /b /wait "" "C:\Program Files\Autodesk\Maya%MAYA_VERSION%\bin\mayabatch.exe" %RESTVAR%) else ("C:\Program Files\Autodesk\Maya%MAYA_VERSION%\bin\maya.exe")
