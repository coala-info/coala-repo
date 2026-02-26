cwlVersion: v1.2
class: CommandLineTool
baseCommand: wig
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
    default: 200
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
outputs:
  - id: output_location
    type:
      - 'null'
      - Directory
    doc: the output location
    outputBinding:
      glob: $(inputs.output_location)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
