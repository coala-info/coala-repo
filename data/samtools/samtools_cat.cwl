cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - cat
label: samtools_cat
doc: Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those on
  the command line.
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM or CRAM files
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
  - id: header_file
    type:
      - 'null'
      - File
    doc: copy the header from FILE [default is 1st input file]
    inputBinding:
      position: 102
      prefix: -h
  - id: output
    type:
      - 'null'
      - string
    doc: output BAM/CRAM
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
  - id: region
    type:
      - 'null'
      - string
    doc: 'filter to region REG. REG can also be #:cstart-cend for specific container
      numbers'
    inputBinding:
      position: 102
      prefix: -r
  - id: part
    type:
      - 'null'
      - string
    doc: Specify part N of M (where N is 1 to M inclusive)
    inputBinding:
      position: 102
      prefix: -p
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Fast mode: don't filter containers to exactly match region"
    inputBinding:
      position: 102
      prefix: -f
  - id: query_containers
    type:
      - 'null'
      - boolean
    doc: Query the total number of indexed containers
    inputBinding:
      position: 102
      prefix: -q
  - id: output_fmt_option
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --output-fmt-option
          separate: true
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: output BAM/CRAM
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
