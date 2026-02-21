cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam
label: leviosam
doc: "LevioSAM is a tool for lifting over alignments from one genome to another. (Note:
  The provided input text is a container runtime error log and does not contain help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
stdout: leviosam.out
