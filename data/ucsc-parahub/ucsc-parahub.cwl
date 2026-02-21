cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHub
label: ucsc-parahub
doc: "A tool from the UCSC Genome Browser utilities. (Note: The provided text contains
  container execution logs and error messages rather than the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub.out
