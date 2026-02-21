cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadNet
label: ucsc-hgloadnet
doc: "A UCSC Genome Browser utility to load net files into a database. (Note: The
  provided text is a container execution error log and does not contain the tool's
  help documentation or argument list.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadnet:482--h0b57e2e_0
stdout: ucsc-hgloadnet.out
