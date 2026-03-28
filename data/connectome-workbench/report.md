# connectome-workbench CWL Generation Report

## connectome-workbench_wb_command

### Tool Description
Connectome Workbench command-line interface

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Washington-University/workbench
- **Stars**: N/A
### Original Help Text
```text
Version: 1.3.2
Commit Date: unknown
Operating System: Linux

Information options:
   -help                       show this help info
   -arguments-help             explain the format of subcommand help info
   -global-options             display options that can be added to any command
   -parallel-help              details on how wb_command uses parallelization
   -cifti-help                 explain the cifti file format and related terms
   -gifti-help                 explain the gifti file format (metric, surface)
   -volume-help                explain volume files, including label volumes
   -version                    show extended version information
   -list-commands              list all processing subcommands
   -list-deprecated-commands   list deprecated subcommands
   -all-commands-help          show all processing subcommands and their help
                                  info - VERY LONG

To get the help information of a processing subcommand, run it without any
   additional arguments.

If the first argument is not recognized, all processing commands that start
   with the argument are displayed.
```


## connectome-workbench_wb_view

### Tool Description
Display usage text, set graphics region size, logging level, disable splash screens, load scenes, change window style, load spec files, set window size and position.

### Metadata
- **Docker Image**: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
- **Homepage**: https://www.humanconnectome.org/software/connectome-workbench
- **Package**: https://anaconda.org/channels/bioconda/packages/connectome-workbench/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wb_view [options] [files]

    [files], if present, can be a single spec file, or multiple data files

Options:
    -help
        display this usage text

    -graphics-size  <X Y>
        Set the size of the graphics region.
        If this option is used you WILL NOT be able
        to change the size of the graphic region. It
        may be useful when image captures of a particular
        size are desired.

    -logging <level>
       Set the logging level.
       Valid Levels are:
           SEVERE
           WARNING
           INFO
           CONFIG
           FINE
           FINER
           FINEST
           ALL
           OFF

    -no-splash
        disable all splash screens

    -scene-load <scene-file-name> <scene-name-or-number>
        load the specified scene file and display the scene 
        in the file that matches by name or number.  Name
        takes precedence over number.  The scene numbers 
        start at one.
        

    -style <style-name>
        change the window style to the specified style
        the following styles are valid on this system:
           Windows
           Fusion
        The selected style is listed on the About wb_view dialog
        available from the File Menu (On Macs: wb_view Menu). 
        Press the "More" button to see the selected style.
        Other styles may be available on other systems.

    -spec-load-all
        load all files in the given spec file, don't show spec file dialog

    -window-size  <X Y>
        Set the size of the browser window

    -window-pos  <X Y>
        Set the position of the browser window
```


## Metadata
- **Skill**: not generated
