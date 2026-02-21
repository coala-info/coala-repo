cwlVersion: v1.2
class: CommandLineTool
baseCommand: para
label: ucsc-para_para
doc: "A tool from the UCSC Genome Browser utilities. (Note: The provided text contains
  container build errors rather than help documentation, so no arguments could be
  extracted.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_para.out
