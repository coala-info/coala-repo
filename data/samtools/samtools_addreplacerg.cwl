cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- addreplacerg
label: samtools_addreplacerg
doc: "Adds or replaces read group tags in a SAM, BAM, or CRAM file.\n\nTool homepage:
  https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_file
  type: File
  doc: Input SAM, BAM, or CRAM file
  inputBinding:
    position: 1
- id: input_fmt
  type:
  - 'null'
  - string
  doc: Specify input format (SAM, BAM, CRAM)
  inputBinding:
    position: 102
    prefix: --input-fmt
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: mode
  type:
  - 'null'
  - string
  doc: Set the mode of operation from one of overwrite_all, orphan_only
  inputBinding:
    position: 102
    prefix: -m
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 102
    prefix: --output-fmt
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: overwrite_rg
  type:
  - 'null'
  - boolean
  doc: Overwrite an existing @RG line
  inputBinding:
    position: 102
    prefix: -w
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: rg_id
  type:
  - 'null'
  - string
  doc: ID of @RG line in existing header to use
  inputBinding:
    position: 102
    prefix: -R
- id: rg_line
  type:
  - 'null'
  - string
  doc: '@RG line text'
  inputBinding:
    position: 102
    prefix: -r
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  inputBinding:
    position: 102
    prefix: --threads
- id: uncompressed_output
  type:
  - 'null'
  - boolean
  doc: Output uncompressed data
  inputBinding:
    position: 102
    prefix: -u
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_file
  type: File
  doc: Where to write output to
  outputBinding:
    glob: output.bam
stdout: output.bam
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
