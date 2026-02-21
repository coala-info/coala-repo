cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopCount
label: kpop_KPopCount
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopCount.out
