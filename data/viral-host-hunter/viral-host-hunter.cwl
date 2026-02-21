cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-host-hunter
label: viral-host-hunter
doc: "A tool for viral host prediction (Note: The provided input text appears to be
  a container engine error log rather than CLI help text; no arguments could be extracted).\n
  \nTool homepage: https://github.com/YuehuaOu/Viral-Host-Hunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1
stdout: viral-host-hunter.out
