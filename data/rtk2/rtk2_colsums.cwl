cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtk2
  - colsums
label: rtk2_colsums
doc: "Reports the column sums of all columns in form of a sorted and an unsorted file.\n\
  \nTool homepage: https://github.com/hildebra/rtk2/"
inputs:
  - id: input_file
    type: File
    doc: path to an .txt file (tab delimited) to rarefy
    inputBinding:
      position: 1
      prefix: -i
  - id: output_prefix
    type: string
    doc: path to a output directory or prefix for output files
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
stdout: rtk2_colsums.out
