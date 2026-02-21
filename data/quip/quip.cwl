cwlVersion: v1.2
class: CommandLineTool
baseCommand: quip
label: quip
doc: "A tool for compression of next-generation sequencing data (Note: The provided
  text appears to be a container build log rather than help text, so no arguments
  could be extracted).\n\nTool homepage: http://homes.cs.washington.edu/%7Edcjones/quip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quip:1.1.8--hb1d24b7_3
stdout: quip.out
