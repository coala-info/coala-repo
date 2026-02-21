cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsfetch
label: ngsfetch
doc: "The provided text does not contain help information for ngsfetch; it is an error
  log indicating a failure to pull or build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/NaotoKubota/ngsfetch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsfetch:0.1.1--pyh7e72e81_0
stdout: ngsfetch.out
