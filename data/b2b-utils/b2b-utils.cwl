cwlVersion: v1.2
class: CommandLineTool
baseCommand: b2b-utils
label: b2b-utils
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to pull or build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/jvolkening/b2b-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
stdout: b2b-utils.out
