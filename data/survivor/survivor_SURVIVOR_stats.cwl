cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - stats
label: survivor_stats
doc: "Report multiple stats over a VCF file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: vcf
    type: File
    doc: "VCF file."
    inputBinding:
      position: 1
  - id: min_size
    type: int
    doc: "Min SV size (disable: -1)."
    inputBinding:
      position: 2
  - id: max_size
    type: int
    doc: "Max SV size (disable: -1)."
    inputBinding:
      position: 3
  - id: min_support
    type: int
    doc: "Min number read support (disable: -1)."
    inputBinding:
      position: 4
  - id: output
    type: string
    doc: "Output summary file prefix (also writes <prefix>_CHR and <prefix>support)."
    inputBinding:
      position: 5
outputs:
  - id: summary_files
    type:
      type: array
      items: File
    doc: "Summary tables by type and size, by chromosome and by support."
    outputBinding:
      glob: '$(inputs.output)*'
  - id: stdout
    type: stdout
    doc: "Type counts printed by the tool"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_stats.out
