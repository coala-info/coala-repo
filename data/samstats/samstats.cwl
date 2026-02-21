cwlVersion: v1.2
class: CommandLineTool
baseCommand: samstats
label: samstats
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/kundajelab/SAMstats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samstats:0.2.2--py_0
stdout: samstats.out
