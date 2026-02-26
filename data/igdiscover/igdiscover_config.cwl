cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - config
label: igdiscover_config
doc: "Configure igdiscover\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: file
    type: File
    doc: Path to the configuration file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_config.out
