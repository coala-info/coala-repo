cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamslice
label: bamslice
doc: "The provided text does not contain help information or usage instructions for
  the 'bamslice' tool. It consists of system logs and error messages related to an
  Apptainer/Singularity container build failure (No space left on device).\n\nTool
  homepage: https://github.com/nebiolabs/bamslice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamslice:0.1.7--h67a98e6_0
stdout: bamslice.out
