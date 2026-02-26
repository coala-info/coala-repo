cwlVersion: v1.2
class: CommandLineTool
baseCommand: squizz
label: squizz
doc: "Detect alignment formats only.\n\nTool homepage: http://ftp.pasteur.fr/pub/gensoft/projects/squizz/"
inputs:
  - id: file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: assume_format
    type:
      - 'null'
      - string
    doc: Assume input format <fmt>
    inputBinding:
      position: 102
      prefix: -f
  - id: convert_format
    type:
      - 'null'
      - string
    doc: Convert into format <fmt>
    inputBinding:
      position: 102
      prefix: -c
  - id: count_entries
    type:
      - 'null'
      - boolean
    doc: Count and report entries number.
    inputBinding:
      position: 102
      prefix: -n
  - id: detect_alignment_formats_only
    type:
      - 'null'
      - boolean
    doc: Detect alignment formats only.
    inputBinding:
      position: 102
      prefix: -A
  - id: detect_sequence_formats_only
    type:
      - 'null'
      - boolean
    doc: Detect sequence formats only.
    inputBinding:
      position: 102
      prefix: -S
  - id: disable_strict_format_checks
    type:
      - 'null'
      - boolean
    doc: Disable strict format checks.
    inputBinding:
      position: 102
      prefix: -s
  - id: list_supported_formats
    type:
      - 'null'
      - boolean
    doc: List all supported formats.
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/squizz:v0.99ddfsg-2-deb_cv1
stdout: squizz.out
