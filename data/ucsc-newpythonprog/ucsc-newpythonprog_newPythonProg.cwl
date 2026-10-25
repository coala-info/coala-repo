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
outputs:
  - id: program_dir
    type: Directory
    doc: Directory named after the program, holding the generated python skeleton
    outputBinding:
      glob: $(inputs.program_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newpythonprog:482--h0b57e2e_2
