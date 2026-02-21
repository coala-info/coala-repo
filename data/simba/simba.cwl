cwlVersion: v1.2
class: CommandLineTool
baseCommand: simba
label: simba
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/pinellolab/simba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba:1.2--pyh7cba7a3_0
stdout: simba.out
