cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - aegean
  - fidibus
label: aegean_fidibus
doc: "The provided text is a log of a failed container build process and does not
  contain help information or usage instructions for the tool.\n\nTool homepage: https://github.com/BrendelGroup/AEGeAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
stdout: aegean_fidibus.out
