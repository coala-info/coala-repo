cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_makespan
label: ccphylo_makespan
doc: "make a DBSCAN given a set of phylip distance matrices.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: classes
    type:
      - 'null'
      - string
    doc: Field(s) containing class weights
    inputBinding:
      position: 101
      prefix: --classes
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input
  - id: key
    type:
      - 'null'
      - int
    doc: Field containing cluster number
    inputBinding:
      position: 101
      prefix: --key
  - id: loads
    type:
      - 'null'
      - type: array
        items: string
    doc: Load on machines double[,double...]
    inputBinding:
      position: 101
      prefix: --loads
  - id: method
    type:
      - 'null'
      - string
    doc: Makespan initial method
    inputBinding:
      position: 101
      prefix: --method
  - id: method_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-m"
    inputBinding:
      position: 101
      prefix: --method_help
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator
    inputBinding:
      position: 101
      prefix: --separator
  - id: tabu
    type:
      - 'null'
      - string
    doc: Makespan tabu search method
    inputBinding:
      position: 101
      prefix: --tabu
  - id: tabu_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-t"
    inputBinding:
      position: 101
      prefix: --tabu_help
  - id: weight
    type:
      - 'null'
      - string
    doc: Weighing method
    inputBinding:
      position: 101
      prefix: --weight
  - id: weight_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-w"
    inputBinding:
      position: 101
      prefix: --weight_help
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
  - id: machine_output_file
    type:
      - 'null'
      - File
    doc: Machine output file
    outputBinding:
      glob: $(inputs.machine_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
