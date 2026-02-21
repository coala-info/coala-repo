cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap
label: metawrap
doc: "MetaWRAP is a pipeline for genome-resolved metagenomic data analysis. (Note:
  The provided help text contains only system error logs and no usage information.)\n
  \nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap.out
