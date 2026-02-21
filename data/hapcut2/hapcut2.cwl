cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapcut2
label: hapcut2
doc: "HapCUT2 is a tool for assembling haplotypes from DNA sequence reads. (Note:
  The provided help text contains a system error message and does not list usage or
  arguments).\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
stdout: hapcut2.out
