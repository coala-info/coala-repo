cwlVersion: v1.2
class: CommandLineTool
baseCommand: primedlamp
label: primedlamp
doc: PRIMEr DEsign for LAMP (Loop-mediated isothermal amplification)
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
stdout: primedlamp.out
