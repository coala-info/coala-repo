cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_case.submit
label: noresm_case.submit
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_case.submit.out
