cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_newcase
label: cesm_create_newcase
doc: "Script to create a new CIME Case Control System (CSS) experimental case.\n\n\
  Tool homepage: https://github.com/ESCOMP/cesm"
inputs:
  - id: case_name
    type: string
    doc: Specify the case name. If this is simply a name (not a path), the case 
      directory is created in the current working directory. This can also be a 
      relative or absolute path specifying where the case should be created; 
      with this usage, the name of the case will be the last component of the 
      path.
    inputBinding:
      position: 101
      prefix: --case
  - id: compiler
    type:
      - 'null'
      - string
    doc: Specify a compiler. To see list of supported compilers for each 
      machine, use the utility ./query_config --machines in this directory. The 
      default value will be the first one listed.
    inputBinding:
      position: 101
      prefix: --compiler
  - id: compset
    type: string
    doc: Specify a compset. To see list of current compsets, use the utility 
      ./query_config --compsets in this directory.
    inputBinding:
      position: 101
      prefix: --compset
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information (very verbose) to file /create_newcase.log
    inputBinding:
      position: 101
      prefix: --debug
  - id: grid
    type: string
    doc: Specify a model grid resolution. To see list of current model 
      resolutions, use the utility ./query_config --grids in this directory.
    inputBinding:
      position: 101
      prefix: --res
  - id: gridfile
    type:
      - 'null'
      - File
    doc: Full pathname of config grid file to use. This should be a copy of 
      config/config_grids.xml with the new user grid changes added to it.
    inputBinding:
      position: 101
      prefix: --gridfile
  - id: handle_preexisting_dirs
    type:
      - 'null'
      - string
    doc: Do not query how to handle pre-existing bld/exe dirs. Valid options are
      (a)bort (r)eplace or (u)se existing. This can be useful if you need to run
      create_newcase non-iteractively.
    inputBinding:
      position: 101
      prefix: --handle-preexisting-dirs
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Use a non-default location for input files. This will change the xml 
      value of DIN_LOC_ROOT.
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: machine
    type:
      - 'null'
      - string
    doc: Specify a machine. The default value is the match to NODENAME_REGEX in 
      config_machines.xml. To see the list of current machines, invoke 
      ./query_config --machines.
    inputBinding:
      position: 101
      prefix: --machine
  - id: mpilib
    type:
      - 'null'
      - string
    doc: Specify the MPI library. To see list of supported mpilibs for each 
      machine, invoke ./query_config --machines. The default is the first 
      listing in MPILIBS in config_machines.xml.
    inputBinding:
      position: 101
      prefix: --mpilib
  - id: multi_driver
    type:
      - 'null'
      - boolean
    doc: Specify that --ninst should modify the number of driver/coupler 
      instances. The default is to have one driver/coupler supporting multiple 
      component instances.
    inputBinding:
      position: 101
      prefix: --multi-driver
  - id: ninst
    type:
      - 'null'
      - int
    doc: Specify number of model ensemble instances. The default is multiple 
      components and one driver/coupler. Use --multi-driver to run multiple 
      driver/couplers in the ensemble.
    inputBinding:
      position: 101
      prefix: --ninst
  - id: pecount
    type:
      - 'null'
      - string
    doc: Specify a target size description for the number of cores. This is used
      to query the appropriate config_pes.xml file and find the optimal 
      PE-layout for your case - if it exists there. Allowed options are 
      ('S','M','L','X1','X2','[0-9]x[0-9]','[0-9]').
    inputBinding:
      position: 101
      prefix: --pecount
  - id: pesfile
    type:
      - 'null'
      - File
    doc: Full pathname of an optional pes specification file. The file can 
      follow either the config_pes.xml or the env_mach_pes.xml format.
    inputBinding:
      position: 101
      prefix: --pesfile
  - id: project
    type:
      - 'null'
      - string
    doc: Specify a project id as used in batch system accounting.
    inputBinding:
      position: 101
      prefix: --project
  - id: queue
    type:
      - 'null'
      - string
    doc: Force batch system to use the specified queue.
    inputBinding:
      position: 101
      prefix: --queue
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print only warnings and error messages
    inputBinding:
      position: 101
      prefix: --silent
  - id: srcroot
    type:
      - 'null'
      - Directory
    doc: Alternative pathname for source root directory. The default is 
      cimeroot/../
    inputBinding:
      position: 101
      prefix: --srcroot
  - id: user_mods_dir
    type:
      - 'null'
      - Directory
    doc: Full pathname to a directory containing any combination of user_nl_* 
      files and a shell_commands script (typically containing xmlchange 
      commands). The directory can also contain an SourceMods/ directory with 
      the same structure as would be found in a case directory.
    inputBinding:
      position: 101
      prefix: --user-mods-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Add additional context (time and file) to log messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: walltime
    type:
      - 'null'
      - string
    doc: Set the wallclock limit for this case in the format (the usual format 
      is HH:MM:SS). You may use env var CIME_GLOBAL_WALLTIME to set this. If 
      CIME_GLOBAL_WALLTIME is not defined in the environment, then the walltime 
      will be the maximum allowed time defined for the queue in 
      config_batch.xml.
    inputBinding:
      position: 101
      prefix: --walltime
  - id: workflow
    type:
      - 'null'
      - string
    doc: A workflow from config_workflow.xml to apply to this case.
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: output_root
    type:
      - 'null'
      - Directory
    doc: Alternative pathname for the directory where case output is written.
    outputBinding:
      glob: $(inputs.output_root)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesm:2.1.3--py39hd40aa7f_3
