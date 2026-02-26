cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - primalbedtools
  - remap
label: primalbedtools_remap
doc: "Remap IDs in a BED file based on an MSA.\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 101
      prefix: --bed
  - id: from_id
    type: string
    doc: The ID to remap from
    inputBinding:
      position: 101
      prefix: --from_id
  - id: msa
    type: File
    doc: Input MSA
    inputBinding:
      position: 101
      prefix: --msa
  - id: to_id
    type: string
    doc: The ID to remap to
    inputBinding:
      position: 101
      prefix: --to_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_remap.out
