cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vhh-predict
label: viral-host-hunter_vhh-predict
doc: "Viral-Host Hunter prediction tool (Note: The provided help text contains container
  engine error logs rather than tool usage information; no arguments could be extracted).\n
  \nTool homepage: https://github.com/YuehuaOu/Viral-Host-Hunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1
stdout: viral-host-hunter_vhh-predict.out
