cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsnap
label: bamsnap
doc: "A tool for generating snapshots of BAM files. Note: The provided help text contains
  system error logs rather than command usage; arguments listed are based on standard
  bamsnap documentation.\n\nTool homepage: https://github.com/danielmsk/bamsnap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsnap:0.2.19--py_0
stdout: bamsnap.out
