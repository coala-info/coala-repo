cwlVersion: v1.2
class: CommandLineTool
baseCommand: masurca_samba.sh
label: masurca_samba.sh
doc: "SAMBA (Scaffolding Aligned Long Reads) is a tool within the MaSuRCA genome assembly
  suite. (Note: The provided text is an error log indicating a 'no space left on device'
  failure during a container build and does not contain usage information or argument
  definitions).\n\nTool homepage: http://masurca.blogspot.co.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
stdout: masurca_samba.sh.out
