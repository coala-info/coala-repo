cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - depad
label: samtools_depad
doc: Convert a padded BAM file to an unpadded BAM file
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output is SAM (default is BAM)
    inputBinding:
      position: 102
      prefix: -s
  - id: input_sam
    type:
      - 'null'
      - boolean
    doc: Input is SAM (default is BAM)
    inputBinding:
      position: 102
      prefix: -S
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Uncompressed BAM output (can't use with -s)
    inputBinding:
      position: 102
      prefix: -u
  - id: fast_compression
    type:
      - 'null'
      - boolean
    doc: Fast compression BAM output (can't use with -s)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: reference
    type:
      - 'null'
      - File
    doc: Padded reference sequence file
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name [stdout]
    inputBinding:
      position: 102
      prefix: -o
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
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
      - string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --output-fmt-option
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Automatically index the output files [off]
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Output file name [stdout]
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
