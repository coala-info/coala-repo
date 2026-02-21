cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxf2chrom
label: gxf2chrom
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or pull the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/alejandrogzi/gxf2chrom"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxf2chrom:0.1.0--h9948957_1
stdout: gxf2chrom.out
