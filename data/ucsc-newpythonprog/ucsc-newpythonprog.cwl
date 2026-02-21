cwlVersion: v1.2
class: CommandLineTool
baseCommand: newPythonProg
label: ucsc-newpythonprog
doc: "Create a new python program template.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newpythonprog:482--h0b57e2e_2
stdout: ucsc-newpythonprog.out
