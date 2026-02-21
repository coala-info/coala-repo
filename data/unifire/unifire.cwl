cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifire
label: unifire
doc: "The provided text does not contain a description of the tool; it appears to
  be a container execution log showing a failure to fetch the OCI image.\n\nTool homepage:
  https://github.com/cmatKhan/unifire/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifire:1.0.1--hdfd78af_0
stdout: unifire.out
