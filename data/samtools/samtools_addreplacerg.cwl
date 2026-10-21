cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- addreplacerg
label: samtools_addreplacerg
doc: 'Adds or replaces read group tags


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
- id: mode
  type:
  - 'null'
  - string
  doc: 'Set the mode of operation: overwrite_all or orphan_only [overwrite_all].'
  inputBinding:
    position: 103
    prefix: -m
- id: output_filename
  type: string
  doc: Where to write the output (-o).
  default: addreplacerg.bam
  inputBinding:
    position: 103
    prefix: -o
- id: rg_line
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: -r
  doc: '@RG line text (-r); repeat for several lines, use \t for tabs.'
  inputBinding:
    position: 103
- id: rg_id
  type:
  - 'null'
  - string
  doc: ID of an @RG line in the existing header to use (-R).
  inputBinding:
    position: 103
    prefix: -R
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Output uncompressed data.
  inputBinding:
    position: 103
    prefix: -u
- id: overwrite_existing
  type:
  - 'null'
  - boolean
  doc: Overwrite an existing @RG line.
  inputBinding:
    position: 103
    prefix: -w
- id: input_fmt
  type:
  - 'null'
  - string
  doc: Specify input format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --input-fmt
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output file.
  inputBinding:
    position: 103
    prefix: --write-index
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
outputs:
- id: output
  type: File
  doc: Alignment file with read groups added or replaced.
  outputBinding:
    glob: $(inputs.output_filename)
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the output when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).bai
    - $(inputs.output_filename).csi
    - $(inputs.output_filename).crai
