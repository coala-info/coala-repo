cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-profile
label: anvio_anvi-profile
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-profile.out
