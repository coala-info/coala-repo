# parmed CWL Generation Report

## parmed

### Tool Description
ParmEd is a package designed to facilitate aiding investigations of biomolecular systems by providing a unified interface to many common topology and coordinate file formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/parmed:3.4.3
- **Homepage**: https://github.com/ParmEd/ParmEd
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/parmed/overview
- **Total Downloads**: 135
- **Last updated**: 2025-09-15
- **GitHub**: https://github.com/ParmEd/ParmEd
- **Stars**: N/A
### Original Help Text
```text
usage: parmed [-h] [-v] [-i FILE] [-p <prmtop>] [-c <inpcrd>] [-O] [-l FILE]
              [--prompt PROMPT] [-n] [-e] [-s] [-r]
              [<prmtop>] [<script>]

positional arguments:
  <prmtop>              Topology file to analyze.
  <script>              File with a series of ParmEd commands to execute.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Input Files:
  -i FILE, --input FILE
                        Script with ParmEd commands to execute. Default reads
                        from stdin. Can be specified multiple times to process
                        multiple input files.
  -p <prmtop>, --parm <prmtop>
                        List of topology files to load into ParmEd. Can be
                        specified multiple times to process multiple
                        topologies.
  -c <inpcrd>, --inpcrd <inpcrd>
                        List of inpcrd files to load into ParmEd. They are
                        paired with the topology files in the same order that
                        each set of files is specified on the command-line.

Output Files:
  -O, --overwrite       Allow ParmEd to overwrite existing files.
  -l FILE, --logfile FILE
                        Log file with every command executed during an
                        interactive ParmEd session. Default is parmed.log

Interpreter Options:
  These options affect how the ParmEd interpreter behaves in certain cases.

  --prompt PROMPT       String to use as a command prompt.
  -n, --no-splash       Prevent printing the greeting logo.
  -e, --enable-interpreter
                        Allow arbitrary single Python commands or blocks of
                        Python code to be run. By default Python commands will
                        not be run as a safeguard for your system. Make sure
                        you trust the source of the ParmEd command before
                        turning this option on.

Error Handling:
  These options control how ParmEd handles various errors and warnings that
  appear occur during the course of Action execution

  -s, --strict          Prevent scripts from running past unrecognized input
                        and actions that end with an error. In interactive
                        mode, actions with unrecognized inputs and failed
                        actions prevent any changes from being made to the
                        topology, but does not quit the interpreter. This is
                        the default behavior.
  -r, --relaxed         Scripts ignore unrecognized input and simply skip over
                        failed actions, executing the rest of the script.
                        Unrecognized input in the interactive interpreter
                        emits a non-fatal warning.
```


## Metadata
- **Skill**: generated
