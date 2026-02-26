cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtk
label: rtk_colsums
doc: "Reports the column sums of all columns in form of a sorted and an unsorted file.\n\
  \nTool homepage: https://github.com/hildebra/Rarefaction/"
inputs:
  - id: mode
    type: string
    doc: Mode for the rarefaction tool kit. For colsums, this is 'colsums'.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: path to an .txt file (tab delimited) to rarefy
    inputBinding:
      position: 102
      prefix: -i
  - id: output_prefix
    type: string
    doc: path to a output directory or prefix for output files
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk:0.93.2--h077b44d_6
stdout: rtk_colsums.out
