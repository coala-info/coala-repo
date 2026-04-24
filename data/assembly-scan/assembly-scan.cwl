cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly-scan
label: assembly-scan
doc: "Generate statistics for a given assembly.\n\nTool homepage: https://github.com/rpetit3/assembly-scan"
inputs:
  - id: assembly
    type: File
    doc: FASTA file to read (gzip or uncompressed)
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print output in a JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: prefix
    type:
      - 'null'
      - string
    doc: ID to use for output
    inputBinding:
      position: 102
      prefix: --prefix
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Print output in a transposed tab-delimited format
    inputBinding:
      position: 102
      prefix: --transpose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly-scan:1.0.0--pyhdfd78af_0
stdout: assembly-scan.out
