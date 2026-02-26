cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_apply
label: wiggletools_apply
doc: "Apply a function to wiggle files.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: function_name
    type: string
    doc: Name of function to be applied
    inputBinding:
      position: 1
  - id: wiggle_files
    type:
      type: array
      items: File
    doc: Wiggle files to process
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
