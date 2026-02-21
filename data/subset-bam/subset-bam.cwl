cwlVersion: v1.2
class: CommandLineTool
baseCommand: subset-bam
label: subset-bam
doc: "A tool for subsetting BAM files. (Note: The provided text contains container
  environment logs and error messages rather than the tool's help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/10XGenomics/subset-bam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subset-bam:1.1.0--h4349ce8_0
stdout: subset-bam.out
