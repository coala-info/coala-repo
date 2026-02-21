cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgi
label: rgi
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/execution process.\n\n
  Tool homepage: https://card.mcmaster.ca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
stdout: rgi.out
