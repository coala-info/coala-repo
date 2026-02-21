cwlVersion: v1.2
class: CommandLineTool
baseCommand: linesToRa
label: ucsc-linestora
doc: "A UCSC Genome Browser utility to convert lines of text to .ra format. (Note:
  The provided help text contains only system error logs and no usage information;
  arguments could not be extracted from the input.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-linestora:482--h0b57e2e_0
stdout: ucsc-linestora.out
