cwlVersion: v1.2
class: CommandLineTool
baseCommand: htmlCheck
label: ucsc-htmlcheck
doc: "Check HTML files for errors. (Note: The provided text contains container execution
  errors and does not list specific command-line arguments.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-htmlcheck:482--h0b57e2e_0
stdout: ucsc-htmlcheck.out
