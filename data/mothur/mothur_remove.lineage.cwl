cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_remove.lineage
doc: "Remove lineage information from sequences.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_file
    type: File
    doc: The input file containing sequences and their lineages.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - File
    doc: A batch file containing commands to execute.
    inputBinding:
      position: 102
      prefix: batch
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The file to write the processed sequences to.
    outputBinding:
      glob: $(inputs.output_file)
  - id: log
    type:
      - 'null'
      - File
    doc: The file to write log messages to.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
