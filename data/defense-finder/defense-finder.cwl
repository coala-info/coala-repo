cwlVersion: v1.2
class: CommandLineTool
baseCommand: defense-finder
label: defense-finder
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://github.com/mdmparis/defense-finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/defense-finder:2.0.1--pyhdfd78af_0
stdout: defense-finder.out
