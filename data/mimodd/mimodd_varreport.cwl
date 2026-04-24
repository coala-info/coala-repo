cwlVersion: v1.2
class: CommandLineTool
baseCommand: varreport
label: mimodd_varreport
doc: "Generates a report from a VCF file.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: a vcf input file
    inputBinding:
      position: 1
  - id: link_formatter_file
    type:
      - 'null'
      - File
    doc: file to read species-specific hyperlink formatting instructions from
    inputBinding:
      position: 102
      prefix: --link
  - id: output_format
    type:
      - 'null'
      - string
    doc: the format of the output file
    inputBinding:
      position: 102
      prefix: --oformat
  - id: species
    type:
      - 'null'
      - string
    doc: the name of the species to be assumed when generating annotations
    inputBinding:
      position: 102
      prefix: --species
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
