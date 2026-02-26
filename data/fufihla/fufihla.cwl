cwlVersion: v1.2
class: CommandLineTool
baseCommand: fufihla
label: fufihla
doc: "Unknown or positional arg: -help\n\nTool homepage: https://github.com/jingqing-hu/FuFiHLA"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --fa
  - id: hifi
    type:
      - 'null'
      - boolean
    doc: Use HiFi mode
    inputBinding:
      position: 101
      prefix: --hifi
  - id: hom_threshold
    type:
      - 'null'
      - float
    doc: Homology threshold
    inputBinding:
      position: 101
      prefix: --hom-threshold
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Use ONT mode
    inputBinding:
      position: 101
      prefix: --ont
  - id: refdir
    type:
      - 'null'
      - Directory
    doc: Reference directory
    inputBinding:
      position: 101
      prefix: --refdir
outputs:
  - id: out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fufihla:0.2.4--hdfd78af_0
