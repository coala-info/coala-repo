cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - update-pinning
label: bioconda-utils_update-pinning
doc: "Bump a package build number and all dependencies as required due to a change
  in pinnings\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: 'Path to folder containing recipes (default: recipes/)'
    default: recipes/
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to Bioconda config (default: config.yml)'
    default: config.yml
    inputBinding:
      position: 2
  - id: cache
    type:
      - 'null'
      - File
    doc: To speed up debugging, use repodata cached locally in the provided 
      filename. If the file does not exist, it will be created the first time.
    default: '-'
    inputBinding:
      position: 103
      prefix: --cache
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    default: '-'
    inputBinding:
      position: 103
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write log to file
    default: '-'
    inputBinding:
      position: 103
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    default: debug
    inputBinding:
      position: 103
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    default: info
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: max_bumps
    type:
      - 'null'
      - int
    doc: Maximum number of recipes that will be updated.
    default: '-'
    inputBinding:
      position: 103
      prefix: --max-bumps
  - id: no_leaves
    type:
      - 'null'
      - boolean
    doc: Only update recipes with dependent packages.
    default: false
    inputBinding:
      position: 103
      prefix: --no-leaves
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob for package[s] to update, as needed due to a change in pinnings
    default: '*'
    inputBinding:
      position: 103
      prefix: --packages
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on exception
    default: false
    inputBinding:
      position: 103
      prefix: --pdb
  - id: skip_additional_channels
    type:
      - 'null'
      - type: array
        items: string
    doc: Skip updating/bumping packges that are already built with compatible 
      pinnings in one of the given channels in addition to those listed in 
      'config'.
    default: '-'
    inputBinding:
      position: 103
      prefix: --skip-additional-channels
  - id: skip_variants
    type:
      - 'null'
      - type: array
        items: string
    doc: Skip packages that use one of the given variant keys.
    default: '-'
    inputBinding:
      position: 103
      prefix: --skip-variants
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit maximum number of processes used.
    default: 16
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_update-pinning.out
