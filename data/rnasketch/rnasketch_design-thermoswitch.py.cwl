cwlVersion: v1.2
class: CommandLineTool
baseCommand: design-thermoswitch.py
label: rnasketch_design-thermoswitch.py
doc: "Design a multi-stable thermoswitch as suggested in the Flamm 2001 publication.\n\
  \nTool homepage: https://github.com/ViennaRNA/RNAsketch"
inputs:
  - id: stdin_file
    type: File
    doc: Text file with one target structure per line, each followed by its temperature, sent to the standard input
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
  - id: graphml_path
    type:
      - 'null'
      - string
    doc: Write a graphml file with the given filename.
    inputBinding:
      position: 101
      prefix: --graphml
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
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop optimization run if no better solution is aquired after (stop) 
      trials.
    inputBinding:
      position: 101
      prefix: --stop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: graphml_file
    type:
      - 'null'
      - File
    doc: Graphml file of the dependency graph
    outputBinding:
      glob: $(inputs.graphml_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-thermoswitch.py.out
stdin: $(inputs.stdin_file.path)
