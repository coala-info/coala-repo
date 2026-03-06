cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- reset
label: samtools_reset
doc: "Reset a SAM/BAM/CRAM file, removing or retaining specific tags and metadata.\n\
  \nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file
  inputBinding:
    position: 200
- id: dupflag
  type: boolean?
  doc: Keeps the duplicate flag as it is
  inputBinding:
    position: 101
    prefix: --dupflag
- id: keep_tag
  type: string[]?
  doc: Aux tags to be retained. Equivalent to -x ^STR
  inputBinding:
    position: 101
    prefix: --keep-tag
- id: no_pg
  type: boolean?
  doc: To have PG entry or not for reset operation
  inputBinding:
    position: 101
    prefix: --no-PG
- id: no_rg
  type: boolean?
  doc: To have RG lines or not
  inputBinding:
    position: 101
    prefix: --no-RG
- id: output_fmt
  type: string?
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 101
    prefix: --output-fmt
- id: reject_pg
  type: string?
  doc: Removes PG line with ID matching to input and succeeding PG lines
  inputBinding:
    position: 101
    prefix: --reject-PG
- id: remove_tag
  type: string[]?
  doc: Aux tags to be removed
  inputBinding:
    position: 101
    prefix: --remove-tag
- id: threads
  type: int?
  doc: Number of additional threads to use
  default: 0
  inputBinding:
    position: 101
    prefix: --threads
- id: output_filename
  type: string?
  doc: Name of the output file
  default: reset.bam
  inputBinding:
    position: 101
    prefix: -o
outputs:
- id: output_file
  type: File
  doc: Output file
  outputBinding:
    glob: $(inputs.output_filename)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
