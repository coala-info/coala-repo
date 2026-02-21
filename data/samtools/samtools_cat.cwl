cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - cat
label: samtools_cat
doc: "Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those on
  the command line.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM or CRAM files to concatenate
    inputBinding:
      position: 1
  - id: bam_list
    type:
      - 'null'
      - File
    doc: list of input BAM/CRAM file names, one per line
    inputBinding:
      position: 102
      prefix: -b
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: "Fast mode: don't filter containers to exactly match region"
    inputBinding:
      position: 102
      prefix: -f
  - id: header_file
    type:
      - 'null'
      - File
    doc: copy the header from FILE [default is 1st input file]
    inputBinding:
      position: 102
      prefix: -h
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
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
  - id: part
    type:
      - 'null'
      - string
    doc: Specify part N of M (where N is 1 to M inclusive)
    inputBinding:
      position: 102
      prefix: -p
  - id: query_containers
    type:
      - 'null'
      - boolean
    doc: Query the total number of indexed containers
    inputBinding:
      position: 102
      prefix: -q
  - id: region
    type:
      - 'null'
      - string
    doc: 'filter to region REG. REG can also be #:cstart-cend for specific container
      numbers'
    inputBinding:
      position: 102
      prefix: -r
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output BAM/CRAM
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
