cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpfbagr
label: rpfbagr
doc: "The provided text does not contain help information or usage instructions for
  the tool 'rpfbagr'. It contains error logs related to a container build process.\n
  \nTool homepage: https://github.com/brsynth/rpfbagr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpfbagr:2.2.2--pyh5e36f6f_0
stdout: rpfbagr.out
