cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomic_regions
label: genomic_regions
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image creation (no space left on device).\n\nTool homepage: https://github.com/vaquerizaslab/genomic_regions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomic_address_service:0.3.2--pyhdfd78af_0
stdout: genomic_regions.out
