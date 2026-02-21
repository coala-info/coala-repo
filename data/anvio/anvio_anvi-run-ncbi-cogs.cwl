cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-run-ncbi-cogs
label: anvio_anvi-run-ncbi-cogs
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure (no space left on device).\n\nTool
  homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-run-ncbi-cogs.out
