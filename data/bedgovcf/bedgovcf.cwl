cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedgovcf
label: bedgovcf
doc: "Convert a BED file to a VCF file according to a YAML config\n\nTool homepage:
  https://github.com/nvnieuwk/bedgovcf"
inputs:
  - id: bed_file
    type: File
    doc: The input BED file
    inputBinding:
      position: 101
      prefix: --bed
  - id: config_file
    type: File
    doc: Configuration file to use for the conversion in YAML format
    inputBinding:
      position: 101
      prefix: --config
  - id: fasta_index_file
    type: File
    doc: The location to the fasta index file
    inputBinding:
      position: 101
      prefix: --fai
  - id: header
    type:
      - 'null'
      - boolean
    doc: The BED file contains a header line
    default: false
    inputBinding:
      position: 101
      prefix: --header
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The name of the sample to use in the VCF file, defaults to the basename
      of the BED file
    inputBinding:
      position: 101
      prefix: --sample
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: The amount of lines to skip in the BED file
    default: 0
    inputBinding:
      position: 101
      prefix: --skip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The location to the output VCF file, defaults to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedgovcf:0.1.1--h9ee0642_1
