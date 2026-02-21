cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam_minimap2
label: sam_minimap2
doc: "The provided text is a container runtime error log and does not contain help
  documentation or argument definitions for the tool.\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam:3.5--0
stdout: sam_minimap2.out
