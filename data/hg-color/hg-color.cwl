cwlVersion: v1.2
class: CommandLineTool
baseCommand: hg-color
label: hg-color
doc: "The provided text does not contain help information for hg-color; it is an error
  log indicating a failure to pull or build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/pierre-morisse/HG-CoLoR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hg-color:1.1.1--he1b5a44_0
stdout: hg-color.out
