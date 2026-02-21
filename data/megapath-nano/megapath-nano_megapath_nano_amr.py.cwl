cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath-nano_megapath_nano_amr.py
label: megapath-nano_megapath_nano_amr.py
doc: "Antimicrobial Resistance (AMR) analysis tool from the MegaPath-Nano suite.\n
  \nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano_megapath_nano_amr.py.out
