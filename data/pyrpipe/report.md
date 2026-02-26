# pyrpipe CWL Generation Report

## pyrpipe

### Tool Description
A lightweight python package for RNA-Seq workflows

### Metadata
- **Docker Image**: quay.io/biocontainers/pyrpipe:0.0.5--py_0
- **Homepage**: https://github.com/urmi-21/pyrpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyrpipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyrpipe/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/urmi-21/pyrpipe
- **Stars**: N/A
### Original Help Text
```text
usage: 
pyrpipe [<pyrpipe options>] --in <script.py> [<script options>]
OR
python <script.py> [<pyrpipe options>] [<script options>]

use pyrpipe_diagnostic command for reports, and tests and installation of RNA-Seq tools

pyrpipe: A lightweight python package for RNA-Seq workflows (version 0.0.5)

optional arguments:
  -h, --help            show this help message and exit
  --threads THREADS     Num processes/threads to use Default:mp.cpu_count()
  --max-memory MEM      Max memory to use (in GB) default: None
  --verbose             Print pyrpipe_engine's stdout and stderr Default:
                        False
  --dry-run             Only print pyrpipe's commands and not execute anything
                        through pyrpipe_engine module Default: False
  --force               Force execution of commands if their target files
                        already exist Default: False
  --safe-mode           Disable file deletions through pyrpipe_engine module
                        Default: False
  --no-logs             Disable pyrpipe logs Default: False
  --param-dir PARAMDIR  Directory containing parameter yaml files Default:
                        ./params
  --logs-dir LOGSDIR    Directory for saving log files Default: ./pyrpipe_logs
  --multiqc             Autorun MultiQC after execution Default: False
  --version             Print version information and exit

Required input file if invoking via pyrpipe command:
  --in INFILE           The input python script
```

