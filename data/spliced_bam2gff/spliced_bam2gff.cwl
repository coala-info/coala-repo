cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliced_bam2gff
label: spliced_bam2gff
doc: "The provided text contains container runtime error logs and does not include
  the help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/nanoporetech/spliced_bam2gff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliced_bam2gff:1.3--he881be0_1
stdout: spliced_bam2gff.out
