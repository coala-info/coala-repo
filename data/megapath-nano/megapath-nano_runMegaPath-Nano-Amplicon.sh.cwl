cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath-nano_runMegaPath-Nano-Amplicon.sh
label: megapath-nano_runMegaPath-Nano-Amplicon.sh
doc: "A script for running MegaPath-Nano on amplicon data. (Note: The provided text
  contains container runtime error messages rather than help documentation, so no
  arguments could be extracted).\n\nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano_runMegaPath-Nano-Amplicon.sh.out
