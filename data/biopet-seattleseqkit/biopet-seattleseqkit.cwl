cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeattleSeqKit
label: biopet-seattleseqkit
doc: "General Biopet options and tools for SeattleSeqKit. Available tools: Filter,
  MergeGenes, MultiFilter.\n\nTool homepage: https://github.com/biopet/seattleseqkit"
inputs:
  - id: tool_name
    type:
      - 'null'
      - string
    doc: Name of the tool to execute (e.g., Filter, MergeGenes, MultiFilter)
    inputBinding:
      position: 1
  - id: tool_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the tool
    inputBinding:
      position: 2
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 103
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
stdout: biopet-seattleseqkit.out
