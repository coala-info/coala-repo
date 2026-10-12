cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakranger
  - wig
label: peakranger_wig
doc: "Converts various genomic data formats to WIG format.\n\nTool homepage: https://github.com/fnaumenko/wigReg"
inputs:
  - id: data_file
    type:
      - 'null'
      - File
    doc: data file
    inputBinding:
      position: 101
      prefix: --data
  - id: ext_length
    type:
      - 'null'
      - int
    doc: read extension length
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: format
    type:
      - 'null'
      - string
    doc: 'the format of the data file, can be one of : bowtie, sam, bam and bed'
    inputBinding:
      position: 101
      prefix: --format
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: compress the output
    inputBinding:
      position: 101
      prefix: --gzip
  - id: split_by_chromosome
    type:
      - 'null'
      - boolean
    doc: generate one wig file per chromosome
    inputBinding:
      position: 101
      prefix: --split
  - id: split_by_strand
    type:
      - 'null'
      - boolean
    doc: generate one wig file per strand
    inputBinding:
      position: 101
      prefix: --strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_prefix
    type: string
    doc: the output location prefix; result files are written as <prefix>_*
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
