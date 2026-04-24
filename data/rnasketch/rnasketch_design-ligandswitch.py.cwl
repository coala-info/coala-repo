cwlVersion: v1.2
class: CommandLineTool
baseCommand: design-ligandswitch.py
label: rnasketch_design-ligandswitch.py
doc: "Design a ligand triggered device.\n\nTool homepage: https://github.com/ViennaRNA/RNAsketch"
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
  - id: ligand
    type:
      - 'null'
      - string
    doc: Binding motif and energy of the ligand
    inputBinding:
      position: 101
      prefix: --ligand
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
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress of optimization
    inputBinding:
      position: 101
      prefix: --progress
  - id: ratio
    type:
      - 'null'
      - string
    doc: Ratio of the alternative to binding competent state in percent
    inputBinding:
      position: 101
      prefix: --ratio
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
stdout: rnasketch_design-ligandswitch.py.out
