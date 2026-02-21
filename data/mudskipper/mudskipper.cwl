cwlVersion: v1.2
class: CommandLineTool
baseCommand: mudskipper
label: mudskipper
doc: "A tool for converting transcript-level alignments to genome-level alignments.
  (Note: The provided text contains error logs from a container runtime and does not
  include help documentation or argument definitions.)\n\nTool homepage: https://github.com/OceanGenomics/mudskipper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mudskipper:0.1.0--h9f5acd7_1
stdout: mudskipper.out
