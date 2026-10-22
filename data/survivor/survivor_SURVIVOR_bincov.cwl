cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - bincov
label: survivor_bincov
doc: "Bin a coverage vector (samtools depth of low mapping quality reads) to a bed file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: cov
    type: File
    doc: "Coverage file (chr, position, depth) from samtools depth of the MQ0 reads."
    inputBinding:
      position: 1
  - id: border
    type: int
    doc: "Border size: positions closer than this are clustered."
    inputBinding:
      position: 2
  - id: min_coverage
    type: int
    doc: "Min coverage to be considered."
    inputBinding:
      position: 3
outputs:
  - id: bed
    type: stdout
    doc: "Clustered regions in bed format (standard output)."
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_bincov.bed
