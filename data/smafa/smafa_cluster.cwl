cwlVersion: v1.2
class: CommandLineTool
baseCommand: smafa cluster
label: smafa_cluster
doc: "Cluster sequences by similarity\n\nTool homepage: https://github.com/wwood/smafa"
inputs:
  - id: input_file
    type: File
    doc: FASTA file to cluster
    inputBinding:
      position: 101
      prefix: --input
  - id: max_divergence
    type:
      - 'null'
      - int
    doc: Maximum divergence to report hits for, for each sequence
    default: not used
    inputBinding:
      position: 101
      prefix: --max-divergence
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
stdout: smafa_cluster.out
