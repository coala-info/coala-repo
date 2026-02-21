cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesm
label: cesm
doc: "The Community Earth System Model (CESM) is a coupled climate model for simulating
  Earth's climate system.\n\nTool homepage: https://github.com/ESCOMP/cesm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesm:2.1.3--py39hd40aa7f_3
stdout: cesm.out
