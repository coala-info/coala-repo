cwlVersion: v1.2
class: CommandLineTool
baseCommand: brawn
label: brawn
doc: "\nTool homepage: https://github.com/SJShaw/brawn"
inputs:
  - id: fasta
    type: File
    inputBinding:
      position: 1
  - id: build_cache
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 102
      prefix: --build-cache
  - id: output_columns
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output-columns
  - id: reference_alignment
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --reference-alignment
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brawn:1.0.2--pyhdfd78af_0
stdout: brawn.out
