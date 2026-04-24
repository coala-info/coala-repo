cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-utils dependent
label: bioconda-utils_dependent
doc: "Print recipes dependent on a package\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: Path to folder containing recipes
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to Bioconda config
    inputBinding:
      position: 2
  - id: dependencies
    type:
      - 'null'
      - type: array
        items: string
    doc: Return recipes in `recipe_folder` in the dependency chain for the 
      packages listed here. Answers the question "what does PACKAGE need?"
    inputBinding:
      position: 103
      prefix: --dependencies
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
      - File
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
  - id: restrict
    type:
      - 'null'
      - boolean
    doc: Restrict --dependencies to packages in `recipe_folder`. Has no effect 
      if --reverse- dependencies, which always looks just in the recipe dir.
    inputBinding:
      position: 103
      prefix: --restrict
  - id: reverse_dependencies
    type:
      - 'null'
      - type: array
        items: string
    doc: Return recipes in `recipe_folder` in the reverse dependency chain for 
      packages listed here. Answers the question "what depends on PACKAGE?"
    inputBinding:
      position: 103
      prefix: --reverse-dependencies
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_dependent.out
