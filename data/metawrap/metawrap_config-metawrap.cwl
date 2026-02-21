cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - config-metawrap
label: metawrap_config-metawrap
doc: "Configure metaWRAP settings and database paths.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap_config-metawrap.out
