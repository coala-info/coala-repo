cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-pslcheck
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages. pslCheck is a UCSC Genome Browser utility used
  to verify the format and consistency of PSL files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcheck:482--h0b57e2e_0
stdout: ucsc-pslcheck.out
