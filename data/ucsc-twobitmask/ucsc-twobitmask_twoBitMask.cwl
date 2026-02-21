cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitMask
label: ucsc-twobitmask_twoBitMask
doc: "A tool to mask sequences in a .2bit file. (Note: The provided text was a container
  execution error log and did not contain the standard help documentation; arguments
  could not be extracted from the input text.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0
stdout: ucsc-twobitmask_twoBitMask.out
