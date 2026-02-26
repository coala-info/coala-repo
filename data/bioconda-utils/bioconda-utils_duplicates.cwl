cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-utils duplicates
label: bioconda-utils_duplicates
doc: "Detect packages in bioconda that have duplicates in the other defined channels.\n\
  \nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: config
    type: string
    doc: Path to yaml file specifying the configuration
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: Channel to check for duplicates
    default: bioconda
    inputBinding:
      position: 102
      prefix: --channel
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Only print removal plan.
    default: false
    inputBinding:
      position: 102
      prefix: --dryrun
  - id: log_command_max_lines
    type:
      - 'null'
      - string
    doc: Limit lines emitted for commands executed
    default: '-'
    inputBinding:
      position: 102
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write log to file
    default: '-'
    inputBinding:
      position: 102
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    default: debug
    inputBinding:
      position: 102
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    default: info
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove packages from anaconda.
    default: false
    inputBinding:
      position: 102
      prefix: --remove
  - id: strict_build
    type:
      - 'null'
      - boolean
    doc: Require version and build to strictly match.
    default: false
    inputBinding:
      position: 102
      prefix: --strict-build
  - id: strict_version
    type:
      - 'null'
      - boolean
    doc: Require version to strictly match.
    default: false
    inputBinding:
      position: 102
      prefix: --strict-version
  - id: url
    type:
      - 'null'
      - boolean
    doc: Print anaconda urls.
    default: false
    inputBinding:
      position: 102
      prefix: --url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_duplicates.out
