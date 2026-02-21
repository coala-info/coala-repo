cwlVersion: v1.2
class: CommandLineTool
baseCommand: erds
label: erds
doc: "Estimation of Rare DNA Sequence variants (ERDS). Note: The provided help text
  contains only system error messages regarding a container build failure and does
  not list command-line arguments.\n\nTool homepage: http://www.utahresearch.org/mingfuzhu/erds/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erds:1.1--pl5.22.0_1
stdout: erds.out
