cwlVersion: v1.2
class: CommandLineTool
baseCommand: design-cofold.py
label: rnasketch_design-cofold.py
doc: "Design a cofold device.\n\nTool homepage: https://github.com/ViennaRNA/RNAsketch"
inputs:
  - id: csv
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
  - id: graphml
    type:
      - 'null'
      - File
    doc: Write a graphml file with the given filename.
    inputBinding:
      position: 101
      prefix: --graphml
  - id: input
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
  - id: package
    type:
      - 'null'
      - string
    doc: 'Chose the calculation package: hotknots, pkiss, nupack, or vrna/ViennaRNA'
    inputBinding:
      position: 101
      prefix: --package
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress of optimization
    inputBinding:
      position: 101
      prefix: --progress
  - id: reporter
    type:
      - 'null'
      - string
    doc: The coding sequence context, excluding the start codon that should be 
      part of the sequence constraint.
    inputBinding:
      position: 101
      prefix: --reporter
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
stdout: rnasketch_design-cofold.py.out
