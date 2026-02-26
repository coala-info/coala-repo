cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAPmaker
label: merquryfk_HAPmaker
doc: "HAPmaker\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: mat
    type: File
    doc: mat file
    inputBinding:
      position: 1
  - id: pat
    type: File
    doc: pat file
    inputBinding:
      position: 2
  - id: child
    type: File
    doc: child file
    inputBinding:
      position: 3
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 4
    inputBinding:
      position: 104
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output to stderr
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_HAPmaker.out
