cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicey
label: dicey
doc: "A tool for simulating and analyzing genomic sequencing data (Note: The provided
  text contains only system error logs and no actual help documentation).\n\nTool
  homepage: https://github.com/gear-genomics/dicey"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
stdout: dicey.out
