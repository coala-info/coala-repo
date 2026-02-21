cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_case.setup
label: noresm_case.setup
doc: "Setup a NorESM (Norwegian Earth System Model) case. Note: The provided text
  contains container runtime error logs rather than the tool's help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_case.setup.out
