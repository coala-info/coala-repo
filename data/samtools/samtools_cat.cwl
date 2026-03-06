cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- cat
label: samtools_cat
doc: |-
  Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those on
  the command line.

  Tool homepage: https://github.com/samtools/samtools
requirements:
  InlineJavascriptRequirement: {}
inputs:
- id: input_files
  type: File[]
  doc: Input BAM or CRAM files to concatenate
  inputBinding:
    position: 103
- id: bam_list
  type: File?
  doc: list of input BAM/CRAM file names, one per line
  inputBinding:
    position: 102
    prefix: -b
- id: fast_mode
  type: boolean?
  doc: "Fast mode: don't filter containers to exactly match region"
  inputBinding:
    position: 102
    prefix: -f
- id: header_file
  type: File?
  doc: copy the header from FILE [default is 1st input file]
  inputBinding:
    position: 102
    prefix: -h
- id: no_pg
  type: boolean?
  doc: do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: output_fmt_option
  type: string[]?
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: part
  type: string?
  doc: Specify part N of M (where N is 1 to M inclusive)
  inputBinding:
    position: 102
    prefix: -p
- id: query_containers
  type: boolean?
  doc: Query the total number of indexed containers
  inputBinding:
    position: 102
    prefix: -q
- id: region
  type: string?
  doc: 'filter to region REG. REG can also be #:cstart-cend for specific container
    numbers'
  inputBinding:
    position: 102
    prefix: -r
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: output_filename
  type: string
  default: "out.bam"
  doc: Name of the output BAM/CRAM file
  inputBinding:
    position: 1
    prefix: -o
outputs:
- id: output_file
  type: File
  doc: output BAM/CRAM
  outputBinding:
    glob: $(inputs.output_filename)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
