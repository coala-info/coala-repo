cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfm
label: orfm
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run the container image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/wwood/OrfM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfm:1.4.0--h577a1d6_0
stdout: orfm.out
