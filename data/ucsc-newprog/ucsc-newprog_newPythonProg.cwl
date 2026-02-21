cwlVersion: v1.2
class: CommandLineTool
baseCommand: newPythonProg
label: ucsc-newprog_newPythonProg
doc: "A tool from the UCSC Genome Browser utilities suite (ucsc-newprog). Note: The
  provided help text contains only container execution logs and error messages, so
  no specific arguments could be extracted.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newprog:482--h0b57e2e_0
stdout: ucsc-newprog_newPythonProg.out
