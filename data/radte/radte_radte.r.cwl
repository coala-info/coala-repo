cwlVersion: v1.2
class: CommandLineTool
baseCommand: radte.r
label: radte_radte.r
doc: "The provided text does not contain help information for the tool; it is a container
  build log showing a failure to fetch an OCI image.\n\nTool homepage: https://github.com/kfuku52/radte"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radte:0.2.3--r44hdfd78af_0
stdout: radte_radte.r.out
