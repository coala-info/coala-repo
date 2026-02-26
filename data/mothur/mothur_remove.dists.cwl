cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_remove.dists
doc: "Remove distances from a distance matrix.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_file
    type: File
    doc: The distance matrix file to process.
    inputBinding:
      position: 1
  - id: groups
    type:
      - 'null'
      - File
    doc: A groups file containing the labels to remove.
    inputBinding:
      position: 102
      prefix: groups
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: A label to remove from the distance matrix.
    inputBinding:
      position: 102
      prefix: label
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The name of the output distance matrix file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
