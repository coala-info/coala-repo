cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_proteinInference
label: pythomics_proteinInference
doc: "A tool for protein inference (Note: The provided text contains container runtime
  errors and does not include the tool's help documentation or usage instructions).\n
  \nTool homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_proteinInference.out
