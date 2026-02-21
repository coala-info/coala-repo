cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadtool
label: tadtool
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/pull process.\n\nTool homepage: https://github.com/vaquerizaslab/tadtool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
stdout: tadtool.out
