cwlVersion: v1.2
class: CommandLineTool
baseCommand: endsInLf
label: ucsc-endsinlf
doc: "A UCSC Genome Browser utility to check if a file ends in a line feed. (Note:
  The provided help text contains only container runtime error messages and does not
  list specific arguments.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-endsinlf:377--h199ee4e_0
stdout: ucsc-endsinlf.out
