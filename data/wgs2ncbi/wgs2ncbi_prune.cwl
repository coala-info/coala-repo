cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgs2ncbi
  - prune
label: wgs2ncbi_prune
doc: "Based on a validation file from NCBI, makes pruned versions of feature tables
  that omit features within regions identified by NCBI.\n\nTool homepage: https://github.com/naturalis/wgs2ncbi"
inputs:
  - id: config_file
    type: File
    doc: config file
    inputBinding:
      position: 101
      prefix: -conf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
stdout: wgs2ncbi_prune.out
