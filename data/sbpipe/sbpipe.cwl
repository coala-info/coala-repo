cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbpipe
label: sbpipe
doc: "Pipelines for systems modelling of biological networks.\n\nTool homepage: http://sbpipe.readthedocs.io"
inputs:
  - id: create_project
    type:
      - 'null'
      - string
    doc: create a project structure
    inputBinding:
      position: 101
      prefix: --create-project
  - id: log_level
    type:
      - 'null'
      - string
    doc: override the log level
    inputBinding:
      position: 101
      prefix: --log-level
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: print logging messages without colors
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: parameter_estimation
    type:
      - 'null'
      - File
    doc: run parameter estimations
    inputBinding:
      position: 101
      prefix: --parameter-estimation
  - id: parameter_scan1
    type:
      - 'null'
      - File
    doc: run parameter scans for 1 model variable
    inputBinding:
      position: 101
      prefix: --parameter-scan1
  - id: parameter_scan2
    type:
      - 'null'
      - File
    doc: run parameter scans for 2 model variables
    inputBinding:
      position: 101
      prefix: --parameter-scan2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not print any log
    inputBinding:
      position: 101
      prefix: --quiet
  - id: show_license
    type:
      - 'null'
      - boolean
    doc: show the license and exit
    inputBinding:
      position: 101
      prefix: --license
  - id: show_logo
    type:
      - 'null'
      - boolean
    doc: show the logo and exit
    inputBinding:
      position: 101
      prefix: --logo
  - id: simulate
    type:
      - 'null'
      - File
    doc: run time course simulations
    inputBinding:
      position: 101
      prefix: --simulate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print debugging output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbpipe:4.21.0--py_0
stdout: sbpipe.out
