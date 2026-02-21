cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybpiper
  - assemble
label: hybpiper_hybpiper assemble
doc: "The provided text does not contain help information for the tool, but rather
  a system error message regarding container image creation (no space left on device).\n
  \nTool homepage: https://github.com/mossmatters/HybPiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_hybpiper assemble.out
