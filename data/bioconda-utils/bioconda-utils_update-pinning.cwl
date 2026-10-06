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
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : self.basename)'
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to Bioconda config (default: config.yml)'
    inputBinding:
      position: 2
      valueFrom: '$(self === null ? null : self.basename)'
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the config names by relative path (for example the files listed 
      under `blacklists:`); they are staged beside the config so the names 
      resolve
  - id: cache
    type:
      - 'null'
      - File
    doc: To speed up debugging, use repodata cached locally in the provided 
      filename. If the file does not exist, it will be created the first time.
    inputBinding:
      position: 103
      prefix: --cache
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    inputBinding:
      position: 103
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write log to file
    inputBinding:
      position: 103
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    inputBinding:
      position: 103
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: max_bumps
    type:
      - 'null'
      - int
    doc: Maximum number of recipes that will be updated.
    inputBinding:
      position: 103
      prefix: --max-bumps
  - id: no_leaves
    type:
      - 'null'
      - boolean
    doc: Only update recipes with dependent packages.
    inputBinding:
      position: 103
      prefix: --no-leaves
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob for package[s] to update, as needed due to a change in pinnings
    inputBinding:
      position: 103
      prefix: --packages
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on exception
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
    inputBinding:
      position: 103
      prefix: --skip-additional-channels
  - id: skip_variants
    type:
      - 'null'
      - type: array
        items: string
    doc: Skip packages that use one of the given variant keys.
    inputBinding:
      position: 103
      prefix: --skip-variants
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit maximum number of processes used.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: recipes_out
    type:
      - 'null'
      - Directory
    doc: Recipe folder after the run (staged writable)
    outputBinding:
      glob: '$(inputs.recipe_folder === null ? "recipes" : inputs.recipe_folder.basename)'
  - id: logfile_out
    type:
      - 'null'
      - File
    doc: Log file written by --logfile
    outputBinding:
      glob: $(inputs.logfile)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.config_files)
      - entry: $(inputs.recipe_folder)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_update-pinning.out
