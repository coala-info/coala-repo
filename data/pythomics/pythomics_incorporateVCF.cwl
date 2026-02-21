cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_incorporateVCF
label: pythomics_incorporateVCF
doc: "The provided text does not contain help information for the tool, but rather
  logs indicating a failure to fetch or build the container image (FATAL: Unable to
  handle docker://quay.io/biocontainers/pythomics). No arguments or usage instructions
  were found in the input.\n\nTool homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_incorporateVCF.out
