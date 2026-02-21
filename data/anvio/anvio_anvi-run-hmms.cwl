cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-run-hmms
label: anvio_anvi-run-hmms
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build a container image due to lack of disk space.
  No arguments could be extracted.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-run-hmms.out
