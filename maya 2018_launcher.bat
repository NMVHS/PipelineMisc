@echo on
echo "Hello";
set MAYA_VERSION=2018

::Set up Maya env vars
set PIPLINE_SCRIPT_PATH=G:\ShawnRoot\Projects\zxPipelineDev

set MAYA_SHELF_PATH=%MAYA_SHELF_PATH%
set MAYA_PLUG_IN_PATH=%MAYA_PLUG_IN_PATH%
set PYTHONPATH=%PYTHONPATH%
set MAYA_SCRIPT_PATH=%MAYA_SCRIPT_PATH%;%PIPLINE_SCRIPT_PATH%

::Launch Maya now
"F:\Program Files\Autodesk\Maya%MAYA_VERSION%\bin\maya.exe"
