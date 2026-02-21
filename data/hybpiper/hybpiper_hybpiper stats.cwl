cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybpiper
  - stats
label: hybpiper_hybpiper stats
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to run the tool due to lack
  of disk space.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_hybpiper stats.out
