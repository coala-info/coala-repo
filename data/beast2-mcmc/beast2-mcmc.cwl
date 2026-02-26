cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast2-mcmc
doc: "BEAST is a cross-platform program for Bayesian evolutionary analysis of molecular
  sequences from biological sequences. It is entirely orientated towards rooted, time-measured
  phylogenies inferred using Heuristic MCMC sampling algorithms.\n\nTool homepage:
  http://www.beast2.org"
inputs:
  - id: input_file
    type: File
    doc: The name of the BEAST XML input file.
    inputBinding:
      position: 1
  - id: errors
    type:
      - 'null'
      - int
    doc: Maximum number of numerical errors before stopping
    inputBinding:
      position: 102
      prefix: -errors
  - id: instances
    type:
      - 'null'
      - int
    doc: Divide site patterns amongst score instances
    inputBinding:
      position: 102
      prefix: -instances
  - id: loglevel
    type:
      - 'null'
      - string
    doc: The level of logging (error, warning, info, debug, trace)
    inputBinding:
      position: 102
      prefix: -loglevel
  - id: options
    type:
      - 'null'
      - boolean
    doc: Display an options dialog
    inputBinding:
      position: 102
      prefix: -options
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow overwriting of log files
    inputBinding:
      position: 102
      prefix: -overwrite
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for all output files
    inputBinding:
      position: 102
      prefix: -prefix
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Allow appending of log files
    inputBinding:
      position: 102
      prefix: -resume
  - id: seed
    type:
      - 'null'
      - int
    doc: Specify a random number seed
    inputBinding:
      position: 102
      prefix: -seed
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of computational threads to use (default 1)
    inputBinding:
      position: 102
      prefix: -threads
  - id: window
    type:
      - 'null'
      - boolean
    doc: Provide a console window
    inputBinding:
      position: 102
      prefix: -window
  - id: working
    type:
      - 'null'
      - boolean
    doc: Change working directory to input file's directory
    inputBinding:
      position: 102
      prefix: -working
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/beast2-mcmc:v2.5.1dfsg-2-deb_cv1
stdout: beast2-mcmc.out
