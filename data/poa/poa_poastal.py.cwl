cwlVersion: v1.2
class: CommandLineTool
baseCommand: poa_poastal.py
label: poa_poastal.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) attempting
  to pull a POA (Partial Order Alignment) container image.\n\nTool homepage: https://github.com/jakecreps/poastal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poa:2.0--h779adbc_3
stdout: poa_poastal.py.out
