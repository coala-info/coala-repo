cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacbio_falcon_fc_run.py
label: pacbio_falcon_fc_run.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  execution and disk space.\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_fc_run.py.out
