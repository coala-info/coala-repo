# nest CWL Generation Report

## nest

### Tool Description
Read SLI code from file(s) or stdin/pipe, execute commands, or set user arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/nest:2.14.0--py36_2
- **Homepage**: http://www.nest-simulator.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/nest/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nest/overview
- **Total Downloads**: 19.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[INFO] [2026.2.26 14:28:41 /opt/conda/conda-bld/nest_1524088722951/work/nest-2.14.0/nestkernel/rng_manager.cpp:238 @ Network::create_rngs_] : Creating default RNGs
[INFO] [2026.2.26 14:28:41 /opt/conda/conda-bld/nest_1524088722951/work/nest-2.14.0/nestkernel/rng_manager.cpp:233 @ Network::create_rngs_] : Deleting existing random number generators
[INFO] [2026.2.26 14:28:41 /opt/conda/conda-bld/nest_1524088722951/work/nest-2.14.0/nestkernel/rng_manager.cpp:238 @ Network::create_rngs_] : Creating default RNGs
[INFO] [2026.2.26 14:28:41 /opt/conda/conda-bld/nest_1524088722951/work/nest-2.14.0/nestkernel/rng_manager.cpp:284 @ Network::create_grng_] : Creating new default global RNG
usage: nest [options] [ - | file [file ...] ]
  file1 file2 ... filen     read SLI code from file1 to filen in ascending order
                            Quits with exit code 126 on error.
  -   --batch               read SLI code from stdin/pipe.
                            Quits with exit code 126 on error.
  -c cmd                    Execute cmd and exit
  -h  --help                print usage and exit
  -v  --version             print version information and exit
      --userargs=arg1:...   put user defined arguments in statusdict::userargs
  -d  --debug               start in debug mode (implies --verbosity=ALL) 
      --verbosity=ALL       turn on all messages.
      --verbosity=DEBUG|STATUS|INFO|WARNING|ERROR|FATAL
                            show messages of this priority and above.
      --verbosity=QUIET     turn off all messages.
```

