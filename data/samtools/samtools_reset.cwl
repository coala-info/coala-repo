cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - reset
label: samtools_reset
doc: Reset alignment records in SAM/BAM/CRAM files
inputs:
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 101
      prefix: -o
  - id: remove_tag
    type:
      - 'null'
      - string
    doc: Aux tags to be removed
    inputBinding:
      position: 101
      prefix: --remove-tag
  - id: keep_tag
    type:
      - 'null'
      - string
    doc: Aux tags to be retained. Equivalent to -x ^STR
    inputBinding:
      position: 101
      prefix: --keep-tag
  - id: reject_pg
    type:
      - 'null'
      - string
    doc: Removes PG line with ID matching to input and succeeding PG lines
    inputBinding:
      position: 101
      prefix: --reject-PG
  - id: no_rg
    type:
      - 'null'
      - boolean
    doc: To have RG lines or not
    inputBinding:
      position: 101
      prefix: --no-RG
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: To have PG entry or not for reset operation
    inputBinding:
      position: 101
      prefix: --no-PG
  - id: dupflag
    type:
      - 'null'
      - boolean
    doc: Keeps the duplicate flag as it is
    inputBinding:
      position: 101
      prefix: --dupflag
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 101
      prefix: --output-fmt
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
