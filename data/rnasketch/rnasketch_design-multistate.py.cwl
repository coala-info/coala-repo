cwlVersion: v1.2
class: CommandLineTool
baseCommand: design-multistate.py
label: rnasketch_design-multistate.py
doc: "Design a multi-stable riboswitch similar to Hoehner 2013 paper.\n\nTool homepage:
  https://github.com/ViennaRNA/RNAsketch"
inputs:
  - id: csv_output
    type:
      - 'null'
      - boolean
    doc: Write output as semi-colon csv file to stdout
    inputBinding:
      position: 101
      prefix: --csv
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug information of library
    inputBinding:
      position: 101
      prefix: --debug
  - id: graphml_file
    type:
      - 'null'
      - File
    doc: Write a graphml file with the given filename.
    inputBinding:
      position: 101
      prefix: --graphml
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read file in *.inp format
    inputBinding:
      position: 101
      prefix: --file
  - id: input_stdin
    type:
      - 'null'
      - boolean
    doc: Read custom structures and sequence constraints from stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: kill
    type:
      - 'null'
      - int
    doc: Timeout value of graph construction in seconds.
    inputBinding:
      position: 101
      prefix: --kill
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode for getting a new sequence: sample, sample_plocal, sample_clocal, random'
    inputBinding:
      position: 101
      prefix: --mode
  - id: number
    type:
      - 'null'
      - int
    doc: Number of designs to generate
    inputBinding:
      position: 101
      prefix: --number
  - id: objective
    type:
      - 'null'
      - int
    doc: 'Chose the objective function: 1 for abs differences and 2 for squared'
    inputBinding:
      position: 101
      prefix: --objective
  - id: package
    type:
      - 'null'
      - string
    doc: 'Chose the calculation package: hotknots, pkiss, nupack, or vrna/ViennaRNA'
    inputBinding:
      position: 101
      prefix: --package
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Show progress of optimization
    inputBinding:
      position: 101
      prefix: --progress
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop optimization run if no better solution is aquired after (stop) 
      trials.
    inputBinding:
      position: 101
      prefix: --stop
  - id: temperature
    type:
      - 'null'
      - float
    doc: Temperature of the energy calculations.
    inputBinding:
      position: 101
      prefix: --temperature
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-multistate.py.out
