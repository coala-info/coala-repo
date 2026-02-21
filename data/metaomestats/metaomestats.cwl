cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaomestats
label: metaomestats
doc: "A tool for calculating statistics on meta-omics data (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/raw-lab/metaome_stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaomestats:0.4--pyh5e36f6f_0
stdout: metaomestats.out
