cwlVersion: v1.2
class: CommandLineTool
baseCommand: igdiscover
label: igdiscover
doc: "IgDiscover is a tool for analyzing antibody repertoires and discovering new
  V genes. (Note: The provided text contains only system error messages and no usage
  information; therefore, no arguments could be extracted.)\n\nTool homepage: https://igdiscover.se/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover.out
