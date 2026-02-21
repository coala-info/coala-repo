cwlVersion: v1.2
class: CommandLineTool
baseCommand: drhip
label: drhip
doc: "A tool for detecting and reporting highly informative positions (Note: Help
  text provided was an error log and did not contain usage details).\n\nTool homepage:
  https://github.com/veg/drhip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drhip:0.1.4--pyhdfd78af_0
stdout: drhip.out
