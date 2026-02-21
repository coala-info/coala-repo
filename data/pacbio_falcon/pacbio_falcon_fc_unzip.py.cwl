cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacbio_falcon_fc_unzip.py
label: pacbio_falcon_fc_unzip.py
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_fc_unzip.py.out
