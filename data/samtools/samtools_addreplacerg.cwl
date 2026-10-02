cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - addreplacerg
label: samtools_addreplacerg
doc: Adds or replaces read group tags in a BAM/SAM/CRAM file.
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: mode
    type:
      - 'null'
      - string
    doc: Set the mode of operation from one of overwrite_all, orphan_only
    inputBinding:
      position: 102
      prefix: -m
  - id: output_file
    type:
      - 'null'
      - string
    doc: Where to write output to
    inputBinding:
      position: 102
      prefix: -o
  - id: rg_line
    type:
      - 'null'
      - string
    doc: '@RG line text'
    inputBinding:
      position: 102
      prefix: -r
  - id: rg_id
    type:
      - 'null'
      - string
    doc: ID of @RG line in existing header to use
    inputBinding:
      position: 102
      prefix: -R
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Output uncompressed data
    inputBinding:
      position: 102
      prefix: -u
  - id: overwrite_existing
    type:
      - 'null'
      - boolean
    doc: Overwrite an existing @RG line
    inputBinding:
      position: 102
      prefix: -w
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: Do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
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
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Where to write output to
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
