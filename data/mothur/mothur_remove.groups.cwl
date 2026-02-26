cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_remove.groups
doc: "Remove groups from a data file.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_file
    type: File
    doc: The input file containing the data.
    inputBinding:
      position: 1
  - id: groups
    type:
      - 'null'
      - File
    doc: A file containing the groups to remove.
    inputBinding:
      position: 102
      prefix: --groups
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The name of the output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
