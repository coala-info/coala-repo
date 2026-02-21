cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeTableList
label: ucsc-maketablelist_makeTableList
doc: "A tool from the UCSC Genome Browser utilities. (Note: The provided help text
  contains only container runtime error messages and does not list usage or arguments.)\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maketablelist:482--h0b57e2e_0
stdout: ucsc-maketablelist_makeTableList.out
