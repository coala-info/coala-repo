cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextpolish2
label: nextpolish2
doc: "NextPolish2 is a tool for genome polishing. (Note: The provided input text contains
  container runtime error messages rather than the tool's help documentation.)\n\n
  Tool homepage: https://github.com/Nextomics/NextPolish2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
stdout: nextpolish2.out
