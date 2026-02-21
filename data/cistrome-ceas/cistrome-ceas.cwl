cwlVersion: v1.2
class: CommandLineTool
baseCommand: ceas
label: cistrome-ceas
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding a container build failure (no space left
  on device).\n\nTool homepage: https://bitbucket.org/cistrome/cistrome-applications-harvard/overview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1
stdout: cistrome-ceas.out
