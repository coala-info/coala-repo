cwlVersion: v1.2
class: CommandLineTool
baseCommand: pretextmap
label: pretextmap
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch operation.\n\nTool homepage:
  https://github.com/wtsi-hpag/PretextMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextmap:0.2.3--h9948957_0
stdout: pretextmap.out
