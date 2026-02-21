cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2bed
label: bedops_bam2bed
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a system error log indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: http://bedops.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_bam2bed.out
