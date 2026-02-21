cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxf2bed
label: gxf2bed
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container due to lack of disk space. Based on
  the tool name, it is likely a utility to convert GXF (GFF/GTF) files to BED format.\n
  \nTool homepage: https://github.com/alejandrogzi/gxf2bed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxf2bed:0.3.2--ha6fb395_0
stdout: gxf2bed.out
