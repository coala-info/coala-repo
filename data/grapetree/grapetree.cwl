cwlVersion: v1.2
class: CommandLineTool
baseCommand: grapetree
label: grapetree
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/achtman-lab/GrapeTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grapetree:2.1--pyh3252c3a_0
stdout: grapetree.out
