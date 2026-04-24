cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - clean-cran-skeleton
label: bioconda-utils_clean-cran-skeleton
doc: "Cleans skeletons created by ``conda skeleton cran``.\n\nBefore submitting to
  conda-forge or Bioconda, recipes generated with ``conda\nskeleton cran`` need to
  be cleaned up: comments removed, licenses fixed, and\nother linting.\n\nUse --no-windows
  for a Bioconda submission.\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe
    type: string
    doc: Path to recipe to be cleaned
    inputBinding:
      position: 1
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    inputBinding:
      position: 102
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write log to file
    inputBinding:
      position: 102
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    inputBinding:
      position: 102
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: "Set logging level (debug, info, warning, error,\n                      \
      \  critical)"
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: no_windows
    type:
      - 'null'
      - boolean
    doc: "Use this when submitting an R package to Bioconda.\n                   \
      \     After a CRAN skeleton is created, any Windows-related\n              \
      \          lines will be removed and the bld.bat file will be\n            \
      \            removed."
    inputBinding:
      position: 102
      prefix: --no-windows
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_clean-cran-skeleton.out
