cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-display-pan
label: anvio_anvi-display-pan
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build and does not contain the help text or usage
  information for the tool.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-display-pan.out
