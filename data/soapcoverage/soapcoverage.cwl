cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapcoverage
label: soapcoverage
doc: "The provided text does not contain help information as it reflects a container
  execution error. soapcoverage is typically used for calculating coverage and depth
  from SOAP alignment files.\n\nTool homepage: http://soap.genomics.org.cn/soapaligner.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapcoverage:2.7.7--0
stdout: soapcoverage.out
