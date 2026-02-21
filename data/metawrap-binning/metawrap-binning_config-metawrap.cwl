cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - binning
label: metawrap-binning_config-metawrap
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image creation
  (no space left on device). MetaWRAP binning is a module for binning metagenomic
  contigs.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-binning:1.3.0
stdout: metawrap-binning_config-metawrap.out
