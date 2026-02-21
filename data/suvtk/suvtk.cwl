cwlVersion: v1.2
class: CommandLineTool
baseCommand: suvtk
label: suvtk
doc: "The provided text does not contain help information or usage instructions for
  suvtk. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/LanderDC/suvtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
stdout: suvtk.out
