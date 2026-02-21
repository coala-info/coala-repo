cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictkpy
label: hictkpy
doc: "The provided text does not contain help information for hictkpy; it is an error
  log indicating a failure to build or run a container due to insufficient disk space.\n
  \nTool homepage: https://github.com/paulsengroup/hictkpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictkpy:1.4.0--py310hc00559c_0
stdout: hictkpy.out
