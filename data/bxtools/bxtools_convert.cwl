cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - convert
label: bxtools_convert
doc: "Convert a BAM to a BX sorted BAM by switching BX and chromosome\n\nTool homepage:
  https://github.com/walaj/bxtools"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: keep_tags
    type:
      - 'null'
      - boolean
    doc: 'Add chromosome tag (CR) and keep other tags. Default: delete all tags'
    inputBinding:
      position: 102
      prefix: --keep-tags
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag to flip for chromosome
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
stdout: bxtools_convert.out
