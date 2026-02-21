cwlVersion: v1.2
class: CommandLineTool
baseCommand: jms-metabolite-services
label: jms-metabolite-services
doc: "A tool for metabolite services. Note: The provided text contains error logs
  rather than help documentation, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/shuzhao-li/JMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jms-metabolite-services:0.5.8--pyhdfd78af_0
stdout: jms-metabolite-services.out
