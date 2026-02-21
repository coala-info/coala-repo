cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap binning
label: metawrap-binning
doc: "The provided text contains error messages related to a container runtime failure
  and does not include the help documentation for the tool. MetaWRAP binning is typically
  used for binning metagenomic assemblies.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-binning:1.3.0
stdout: metawrap-binning.out
