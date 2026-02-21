cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_incorporateGFF
label: pythomics_incorporateGFF
doc: "Incorporate GFF annotations (Note: The provided text is a container runtime
  error log and does not contain usage information or argument definitions).\n\nTool
  homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_incorporateGFF.out
