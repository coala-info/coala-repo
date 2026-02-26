cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_sort.seqs
doc: "Sorts sequences based on their labels.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_file
    type: File
    doc: The input file containing sequences to be sorted.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - File
    doc: A batch file containing commands to execute.
    inputBinding:
      position: 102
      prefix: --batch
  - id: group
    type:
      - 'null'
      - string
    doc: The group name to assign to the sequences.
    inputBinding:
      position: 102
      prefix: --group
  - id: label
    type:
      - 'null'
      - string
    doc: The label to assign to the sequences.
    inputBinding:
      position: 102
      prefix: --label
  - id: logfile
    type:
      - 'null'
      - File
    doc: The name of the log file to write output to.
    inputBinding:
      position: 102
      prefix: --logfile
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The name of the output file where sorted sequences will be written.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
