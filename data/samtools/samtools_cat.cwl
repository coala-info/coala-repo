cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- cat
label: samtools_cat
doc: 'Concatenate BAMs or CRAMs


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input BAM/CRAM files, concatenated in order.
  inputBinding:
    position: 104
- id: bam_list
  type:
  - 'null'
  - File
  doc: List of input BAM/CRAM file names, one per line (-b); read before the command-line files.
  inputBinding:
    position: 103
    prefix: -b
- id: header_file
  type:
  - 'null'
  - File
  doc: Copy the header from this file [default is the first input file].
  inputBinding:
    position: 103
    prefix: -h
- id: output_filename
  type: string
  doc: Output BAM/CRAM file (-o).
  default: cat.bam
  inputBinding:
    position: 103
    prefix: -o
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: region
  type:
  - 'null'
  - string
  doc: 'CRAM only: filter to region REG; REG can also be #:cstart-cend for container numbers.'
  inputBinding:
    position: 103
    prefix: -r
- id: part
  type:
  - 'null'
  - string
  doc: 'CRAM only: specify part N of M (N from 1 to M inclusive), as N/M.'
  inputBinding:
    position: 103
    prefix: -p
- id: fast
  type:
  - 'null'
  - boolean
  doc: 'CRAM only: fast mode, do not filter containers to exactly match the region.'
  inputBinding:
    position: 103
    prefix: -f
- id: query_containers
  type:
  - 'null'
  - boolean
  doc: 'CRAM only: query the total number of indexed containers.'
  inputBinding:
    position: 103
    prefix: -q
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
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
outputs:
- id: output
  type: File
  doc: Concatenated BAM/CRAM file.
  outputBinding:
    glob: $(inputs.output_filename)
