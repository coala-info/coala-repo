cwlVersion: v1.2
class: CommandLineTool
baseCommand: physiofit4galaxy
label: physiofit4galaxy
doc: "Physiofit4galaxy tool (Note: The provided text is a system error log regarding
  container image retrieval and does not contain help documentation or argument definitions).\n\
  \nTool homepage: https://github.com/MetaSys-LISBP/PhysioFit4Galaxy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit4galaxy:2.2.1--pyhdfd78af_1
stdout: physiofit4galaxy.out
