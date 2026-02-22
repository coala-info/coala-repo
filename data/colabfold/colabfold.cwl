cwlVersion: v1.2
class: CommandLineTool
baseCommand: colabfold
label: colabfold
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a Singularity/Docker container execution failure
  (no space left on device).\n\nTool homepage: https://github.com/sokrypton/ColabFold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colabfold:1.5.5--pyh7cba7a3_2
stdout: colabfold.out
