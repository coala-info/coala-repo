cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_reduce
label: ffindex_ffindex_reduce
doc: "Run a program on the entries of an ffindex (the program reads them) and print\
  \ the result.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: data_file
    type: File
    doc: Input ffindex data file
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: Input ffindex index file
    inputBinding:
      position: 2
  - id: program
    type: string
    doc: Program to execute
    inputBinding:
      position: 3
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments of the program
    inputBinding:
      position: 4
outputs:
  - id: stdout_results
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_reduce.out
