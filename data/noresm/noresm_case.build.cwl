cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_case.build
label: noresm_case.build
doc: "Build a NorESM (Norwegian Earth System Model) case. Note: The provided text
  appears to be a container runtime error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_case.build.out
