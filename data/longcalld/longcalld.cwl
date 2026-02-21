cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcalld
label: longcalld
doc: "A tool for long-read variant calling (Note: The provided text contains container
  runtime errors and does not include the tool's help documentation).\n\nTool homepage:
  https://github.com/yangao07/longcallD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcalld:0.0.8--h7d57edc_0
stdout: longcalld.out
