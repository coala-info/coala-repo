cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf-regions
label: gvcf-regions
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error message regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/lijiayong/gvcf_regions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf-regions:2016.06.23--py35_0
stdout: gvcf-regions.out
