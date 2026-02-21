cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-db-info
label: anvio-minimal_anvi-db-info
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure (no space left on device).\n\nTool
  homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-db-info.out
