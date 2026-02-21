cwlVersion: v1.2
class: CommandLineTool
baseCommand: narfmap
label: narfmap
doc: "The provided text does not contain help information or usage instructions for
  narfmap. It contains error logs related to a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/Emiller88/NARFMAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/narfmap:1.4.2--h5ca1c30_4
stdout: narfmap.out
