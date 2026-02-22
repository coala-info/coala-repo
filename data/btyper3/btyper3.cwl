cwlVersion: v1.2
class: CommandLineTool
baseCommand: btyper3
label: btyper3
doc: "B. cereus group typing and virulence/AMR gene detection\n\nTool homepage: https://github.com/lmc297/BTyper3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/btyper3:3.4.0--pyhdfd78af_0
stdout: btyper3.out
