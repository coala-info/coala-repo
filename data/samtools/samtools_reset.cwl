cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- reset
label: samtools_reset
doc: 'Revert aligner changes in reads


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file.
  inputBinding:
    position: 104
- id: output_filename
  type: string
  doc: Output file (-o).
  default: reset.bam
  inputBinding:
    position: 103
    prefix: -o
- id: remove_tag
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --remove-tag
  doc: Aux tags to be removed (-x); comma separated, repeatable.
  inputBinding:
    position: 103
- id: keep_tag
  type:
  - 'null'
  - string
  doc: Aux tags to be retained; same as -x ^STR.
  inputBinding:
    position: 103
    prefix: --keep-tag
- id: reject_pg
  type:
  - 'null'
  - string
  doc: Remove the PG line with this ID and the succeeding PG lines.
  inputBinding:
    position: 103
    prefix: --reject-PG
- id: no_rg
  type:
  - 'null'
  - boolean
  doc: Drop the RG lines.
  inputBinding:
    position: 103
    prefix: --no-RG
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG entry for the reset operation.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: dupflag
  type:
  - 'null'
  - boolean
  doc: Keep the duplicate flag as it is.
  inputBinding:
    position: 103
    prefix: --dupflag
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
outputs:
- id: output
  type: File
  doc: Alignment file with aligner changes reverted.
  outputBinding:
    glob: $(inputs.output_filename)
