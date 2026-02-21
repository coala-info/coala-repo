cwlVersion: v1.2
class: CommandLineTool
baseCommand: muspinsim
label: muspinsim
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for muspinsim. As a result, no arguments or tool descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/muon-spectroscopy-computational-project/muspinsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muspinsim:2.3.0
stdout: muspinsim.out
