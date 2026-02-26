# noresm CWL Generation Report

## noresm_create_newcase

### Tool Description
Script to create a new CIME Case Control System (CSS) experimental case.

### Metadata
- **Docker Image**: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
- **Homepage**: https://github.com/NorESMhub/NorESM
- **Package**: https://anaconda.org/channels/bioconda/packages/noresm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/noresm/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NorESMhub/NorESM
- **Stars**: N/A
### Original Help Text
```text
usage: create_newcase [-h] [-d] [-v] [-s] --case CASENAME --compset COMPSET
                      --res GRID [--machine MACHINE] [--compiler COMPILER]
                      [--multi-driver] [--ninst NINST] [--mpilib MPILIB]
                      [--project PROJECT] [--pecount PECOUNT]
                      [--user-mods-dir USER_MODS_DIR] [--pesfile PESFILE]
                      [--gridfile GRIDFILE] [--srcroot SRCROOT]
                      [--output-root OUTPUT_ROOT] [--walltime WALLTIME]
                      [-q QUEUE] [--handle-preexisting-dirs {a,r,u}]
                      [-i INPUT_DIR]

Script to create a new CIME Case Control System (CSS) experimental case.

optional arguments:
  -h, --help            show this help message and exit
  -d, --debug           Print debug information (very verbose) to file /create_newcase.log
  -v, --verbose         Add additional context (time and file) to log messages
  -s, --silent          Print only warnings and error messages
  --case CASENAME, -case CASENAME
                        (required) Specify the case name. 
                        If this is simply a name (not a path), the case directory is created in the current working directory.
                        This can also be a relative or absolute path specifying where the case should be created;
                        with this usage, the name of the case will be the last component of the path.
  --compset COMPSET, -compset COMPSET
                        (required) Specify a compset. 
                        To see list of current compsets, use the utility ./query_config --compsets in this directory.
  --res GRID, -res GRID
                        (required) Specify a model grid resolution. 
                        To see list of current model resolutions, use the utility 
                        ./query_config --grids in this directory.
  --machine MACHINE, -mach MACHINE
                        Specify a machine. The default value is the match to NODENAME_REGEX in config_machines.xml. To see 
                        the list of current machines, invoke ./query_config --machines.
  --compiler COMPILER, -compiler COMPILER
                        Specify a compiler. 
                        To see list of supported compilers for each machine, use the utility 
                        ./query_config --machines in this directory. 
                        The default value will be the first one listed.
  --multi-driver        Specify that --ninst should modify the number of driver/coupler instances. 
                        The default is to have one driver/coupler supporting multiple component instances.
  --ninst NINST         Specify number of model ensemble instances. 
                        The default is multiple components and one driver/coupler. 
                        Use --multi-driver to run multiple driver/couplers in the ensemble.
  --mpilib MPILIB, -mpilib MPILIB
                        Specify the MPI library. To see list of supported mpilibs for each machine, invoke ./query_config --machines.
                        The default is the first listing in MPILIBS in config_machines.xml.
  --project PROJECT, -project PROJECT
                        Specify a project id as used in batch system accounting.
  --pecount PECOUNT, -pecount PECOUNT
                        Specify a target size description for the number of cores. 
                        This is used to query the appropriate config_pes.xml file and find the 
                        optimal PE-layout for your case - if it exists there. 
                        Allowed options are  ('S','M','L','X1','X2','[0-9]x[0-9]','[0-9]').
  --user-mods-dir USER_MODS_DIR
                        Full pathname to a directory containing any combination of user_nl_* files 
                        and a shell_commands script (typically containing xmlchange commands). 
                        The directory can also contain an SourceMods/ directory with the same structure 
                        as would be found in a case directory.
  --pesfile PESFILE     Full pathname of an optional pes specification file. 
                        The file can follow either the config_pes.xml or the env_mach_pes.xml format.
  --gridfile GRIDFILE   Full pathname of config grid file to use. 
                        This should be a copy of config/config_grids.xml with the new user grid changes added to it. 
  --srcroot SRCROOT     Alternative pathname for source root directory. The default is cimeroot/../
  --output-root OUTPUT_ROOT
                        Alternative pathname for the directory where case output is written.
  --walltime WALLTIME   Set the wallclock limit for this case in the format (the usual format is HH:MM:SS). 
                        You may use env var CIME_GLOBAL_WALLTIME to set this. 
                        If CIME_GLOBAL_WALLTIME is not defined in the environment, then the walltime
                        will be the maximum allowed time defined for the queue in config_batch.xml.
  -q QUEUE, --queue QUEUE
                        Force batch system to use the specified queue. 
  --handle-preexisting-dirs {a,r,u}
                        Do not query how to handle pre-existing bld/exe dirs. 
                        Valid options are (a)bort (r)eplace or (u)se existing. 
                        This can be useful if you need to run create_newcase non-iteractively.
  -i INPUT_DIR, --input-dir INPUT_DIR
                        Use a non-default location for input files. This will change the xml value of DIN_LOC_ROOT.
```

