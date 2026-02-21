cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - reset
label: samtools_reset
doc: "Reset a SAM/BAM/CRAM file, removing or retaining specific tags and metadata.\n\
  \nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: dupflag
    type:
      - 'null'
      - boolean
    doc: Keeps the duplicate flag as it is
    inputBinding:
      position: 101
      prefix: --dupflag
  - id: keep_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Aux tags to be retained. Equivalent to -x ^STR
    inputBinding:
      position: 101
      prefix: --keep-tag
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: To have PG entry or not for reset operation
    inputBinding:
      position: 101
      prefix: --no-PG
  - id: no_rg
    type:
      - 'null'
      - boolean
    doc: To have RG lines or not
    inputBinding:
      position: 101
      prefix: --no-RG
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 101
      prefix: --output-fmt
  - id: reject_pg
    type:
      - 'null'
      - string
    doc: Removes PG line with ID matching to input and succeeding PG lines
    inputBinding:
      position: 101
      prefix: --reject-PG
  - id: remove_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Aux tags to be removed
    inputBinding:
      position: 101
      prefix: --remove-tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
