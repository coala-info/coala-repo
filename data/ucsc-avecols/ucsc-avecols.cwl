cwlVersion: v1.2
class: CommandLineTool
baseCommand: aveCols
label: ucsc-avecols
doc: "Average columns in a file. This tool calculates the average value for each column
  across multiple rows in a provided input file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file containing columns of numbers to be averaged.
    inputBinding:
      position: 1
  - id: output_name
    type: ['null', string]
    default: avecols.out
    doc: Name of the output file (standard output of the tool)
outputs:
  - id: output_file
    type: File
    doc: Output file where the averaged column results will be written.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-avecols:482--h0b57e2e_0
stdout: $(inputs.output_name)
