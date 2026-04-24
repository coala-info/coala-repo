cwlVersion: v1.2
class: CommandLineTool
baseCommand: adas-chain
label: adas_adas-chain
doc: "Long Reads Alignment via Anchor Chaining\n\nTool homepage: https://github.com/jianshu93/adas"
inputs:
  - id: query
    type: File
    doc: Query FASTA file
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output path to write the results (SAM format)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
