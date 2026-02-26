cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpsw
label: gpsw
doc: "GPSW: A tool for analysing and processing Global Protein Stability Profiling
  data.\n\nTool homepage: https://github.com/niekwit/gps-orfeome"
inputs:
  - id: sub_command
    type: string
    doc: Sub-command help
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
stdout: gpsw.out
