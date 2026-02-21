cwlVersion: v1.2
class: CommandLineTool
baseCommand: rvtest
label: rvtests_rvtest
doc: "Rare Variant Association Analysis\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: rvtests_rvtest.out
