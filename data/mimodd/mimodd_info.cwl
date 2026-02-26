cwlVersion: v1.2
class: CommandLineTool
baseCommand: info
label: mimodd_info
doc: "Show information about the input file\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: 'input file (supported formats: sam, bam, vcf, bcf, fasta)'
    inputBinding:
      position: 1
  - id: output_format
    type:
      - 'null'
      - string
    doc: format for the output
    default: txt
    inputBinding:
      position: 102
      prefix: --oformat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
