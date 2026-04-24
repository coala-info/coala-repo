cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi_unpack
label: fermi_unpack
doc: "Unpack a BWT sequence file\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: seqs_bwt
    type: File
    doc: The BWT sequence file to unpack
    inputBinding:
      position: 1
  - id: index
    type:
      - 'null'
      - int
    doc: index of the read to output, starting from 0
    inputBinding:
      position: 102
      prefix: -i
  - id: memory_mapped
    type:
      - 'null'
      - boolean
    doc: load the FM-index as a memory mapped file
    inputBinding:
      position: 102
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_unpack.out
