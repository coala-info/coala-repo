cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - stat
label: bxtools_stats
doc: "Gather BX-level statistics\n\nTool homepage: https://github.com/walaj/bxtools"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: tag
    type:
      - 'null'
      - string
    doc: Collect stats by a tag other than BX (e.g. MI)
    inputBinding:
      position: 102
      prefix: --tag
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
stdout: bxtools_stats.out
