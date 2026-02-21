cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapaligner
label: soapaligner
doc: "The provided text is an error log from a container runtime environment and does
  not contain help information or usage instructions for the tool.\n\nTool homepage:
  http://soap.genomics.org.cn/soapaligner.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapaligner:2.21--0
stdout: soapaligner.out
