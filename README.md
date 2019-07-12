#Pipeline Setup Notes

## Install Deadline
### Install Repository
1.  Install Deadline Repository to the server/shared location.
2.  Install MongoDB to local machine (Do not install MongoDB to server).
3.  Open the port in window firewall.
    MongoDB Hostname: cg-iii;10.0.8.73
    MongoDB port: 27100

### Install client
1.  Install client to each machine
2.  Add slave instances (Have to enable the privilege in Manage Usergroup option).
3.  Configurate slave GPU/CPU affinity.

### Install submission scripts
1.  Install on one of the local machines and copy shelve tools / script to server
2.  add userSetup.py to server script path and load DeadlineClient.mel on startup

## Centralize plugins

### Create .bat Launcher for Maya
1.  Include centralized plugins / shelves / modules etc....
    *append server paths*

    set MAYA_SHELF_PATH=%MAYA_SHELF_PATH%;%PIPELINE_MAYA_COMMON%\shelves
    set MAYA_PLUG_IN_PATH=%MAYA_PLUG_IN_PATH%;%PIPELINE_MAYA_COMMON%\plugins
    set PYTHONPATH=%PYTHONPATH%;%PIPELINE_MAYA_COMMON%\scripts
    set MAYA_PRESET_PATH=%MAYA_PRESET_PATH%;%PIPELINE_MAYA_COMMON%\presets
    set MAYA_MODULE_PATH=%MAYA_MODULE_PATH%;%PIPELINE_MAYA_COMMON%\modules
    set MAYA_SCRIPT_PATH=%MAYA_SCRIPT_PATH%;%PIPELINE_MAYA_COMMON%\scripts

2.  Redshift Custom Install
    https://docs.redshift3d.com/display/RSDOCS/Custom+Install+Locations?product=maya

    *point COREDATA to server
    point local to local
    point license to local
    all needs to specified explicitly*

    set REDSHIFT_COREDATAPATH=%PIPELINE_REDSHIFT_COMMON%\redshift_v%REDSHIFT_VERSION%
    set REDSHIFT_LOCALDATAPATH=C:\ProgramData\Redshift
    set REDSHIFT_PROCEDURALSPATH=%REDSHIFT_COREDATAPATH%\Procedurals
    set REDSHIFT_PREFSPATH=%REDSHIFT_LOCALDATAPATH%\preferences.xml
    set REDSHIFT_LICENSEPATH=%REDSHIFT_LOCALDATAPATH%

3.  lastline "C:\Program Files\Autodesk\Maya%MAYA_VERSION%\bin\mayabatch.exe"

### Create .bat Launcher for MayaBatch
1.  Same as Maya launcher, except last line:
    start /b /wait "" "C:\Program Files\Autodesk\Maya%MAYA_VERSION%\bin\mayabatch.exe" %*

## Deadline render executable configuration
We set the specific .bat launcher for deadline to pickup, now we need to tell deadline where it is.

### Include MayaBatchLauncherPath in .bat launcher
1.  set MAYABATCH_LAUNCHER_PATH=Z:\System\Launchers\Maya\Configs\MayaBatch_%MAYA_VERSION%_RS_%REDSHIFT_VERSION%.bat

### Include MayaBatchLauncherPath in job subbmitter
1.  Add this to the end of "proc string WriteJobFilesAndSubmit()" in SubmitToDeadline.mel before $fileId closed.
    fprint $fileId ("MayaBatchLauncherPath=" + `getenv "MAYABATCH_LAUNCHER_PATH"` + "\n");

### Tell Deadline to find the right executeble based on MayaBatchLauncherPath
1.  Modify MayaBatch.py in [DeadlineRepository]\plugins\MayaBatch
    https://forums.thinkboxsoftware.com/t/give-render-executable-at-submission/5832/6

    Add this to "def RenderExecutable( self )":
    mayaExecutable = self.deadlinePlugin.GetPluginInfoEntry( "MayaBatchLauncherPath" )
    return mayaExecutable

2.  Modify MayaBatch.options in [DeadlineRepository]\plugins\MayaBatch
    Add the following entry:

    [MayaBatchLauncherPath]
    Type=label
    Label=Maya Batch Launcher Path
    Category=Maya Info
    Index=1
    Description=This parameter defines the .bat launcher path for deadline render executable.
    Required=false
    DisableIfBlank=true
