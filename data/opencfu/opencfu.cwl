cwlVersion: v1.2
class: CommandLineTool
baseCommand: opencfu
label: opencfu
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to pull or build the container image due to lack of disk
  space.\n\nTool homepage: https://github.com/qgeissmann/OpenCFU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/opencfu:v3.9.0-3-deb_cv1
stdout: opencfu.out
