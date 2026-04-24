cwlVersion: v1.2
class: CommandLineTool
baseCommand: design-energyshift.py
label: rnasketch_design-energyshift.py
doc: "Design a multi-stable riboswitch similar using Boltzmann sampling.\n\nTool homepage:
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
  - id: kill_timeout
    type:
      - 'null'
      - int
    doc: Timeout value of graph construction in seconds.
    inputBinding:
      position: 101
      prefix: --kill
  - id: model
    type:
      - 'null'
      - string
    doc: 'Model for getting a new sequence: uniform, nussinov, basepairs, stacking'
    inputBinding:
      position: 101
      prefix: --model
  - id: number_of_designs
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
  - id: stop_trials
    type:
      - 'null'
      - int
    doc: Stop optimization run of unpaired bases if no better solution is 
      aquired after (stop) trials. 0 is no local optimization.
    inputBinding:
      position: 101
      prefix: --stop
  - id: target_energies
    type:
      - 'null'
      - string
    doc: Target Energies for design. String of comma separated float values.
    inputBinding:
      position: 101
      prefix: --energies
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
stdout: rnasketch_design-energyshift.py.out
