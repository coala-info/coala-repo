cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqtk
label: fastqtk
doc: "The provided text does not contain help information for fastqtk; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/ndaniel/fastqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
stdout: fastqtk.out
