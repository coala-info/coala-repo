cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - binning
label: metawrap-binning_metawrap
doc: "MetaWRAP binning module for metagenomic binning. Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-binning:1.3.0
stdout: metawrap-binning_metawrap.out
