cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvet-sc
label: velvet-sc
doc: "The provided text does not contain help information or usage instructions. It
  contains container runtime logs and a fatal error message indicating a failure to
  fetch or build the image.\n\nTool homepage: https://github.com/castleofsolace/VelvetScriptHub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet-sc:0.7.62--pl5.22.0_0
stdout: velvet-sc.out
