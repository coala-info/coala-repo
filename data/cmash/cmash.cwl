cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmash
label: cmash
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
stdout: cmash.out
