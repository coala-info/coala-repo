cwlVersion: v1.2
class: CommandLineTool
baseCommand: newPythonProg
label: ucsc-newpythonprog_newPythonProg
doc: "Make a skeleton for a new python program\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: program_name
    type: string
    doc: The name of the program
    inputBinding:
      position: 1
  - id: usage_statement
    type: string
    doc: The usage statement for the program
    inputBinding:
      position: 2
  - id: xxx
    type:
      - 'null'
      - string
    doc: An option with a placeholder value
    inputBinding:
      position: 103
      prefix: -xxx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newpythonprog:482--h0b57e2e_2
stdout: ucsc-newpythonprog_newPythonProg.out
