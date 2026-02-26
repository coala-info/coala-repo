cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi example
label: fermi_example
doc: "Usage: fermi example [-ceU] [-k ecKmer] [-l utgKmer] <in.fq>\n\nTool homepage:
  https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: U
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -U
  - id: c
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -c
  - id: e
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -e
  - id: ecKmer
    type:
      - 'null'
      - string
    doc: ecKmer
    inputBinding:
      position: 102
      prefix: -k
  - id: utgKmer
    type:
      - 'null'
      - string
    doc: utgKmer
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_example.out
