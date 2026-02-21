cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbitax2lin
label: ncbitax2lin
doc: "A tool to convert NCBI taxonomy data into a lineage format. (Note: The provided
  text is an error log and does not contain usage information or argument definitions.)\n
  \nTool homepage: https://github.com/zyxue/ncbitax2lin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbitax2lin:3.0.0--pyhdfd78af_0
stdout: ncbitax2lin.out
