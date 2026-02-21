cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch
label: rnasketch
doc: "The provided text does not contain help information for rnasketch; it is a log
  of a failed container build/execution attempt.\n\nTool homepage: https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch.out
