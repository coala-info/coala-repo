cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbalign
label: pacbio_falcon_pbalign
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build a container image due to lack of disk space.\n\nTool
  homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_pbalign.out
