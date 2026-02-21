cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_fastadigest
label: pythomics_fastadigest
doc: "The provided text does not contain help information for the tool. It contains
  container engine log messages indicating a failure to fetch or build the container
  image.\n\nTool homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_fastadigest.out
