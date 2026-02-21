cwlVersion: v1.2
class: CommandLineTool
baseCommand: raToLines
label: ucsc-ratolines
doc: "A UCSC Genome Browser utility to convert .ra files to lines. (Note: The provided
  text is a container execution error and does not contain help documentation.)\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ratolines:482--h0b57e2e_0
stdout: ucsc-ratolines.out
