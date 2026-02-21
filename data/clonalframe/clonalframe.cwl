cwlVersion: v1.2
class: CommandLineTool
baseCommand: clonalframe
label: clonalframe
doc: "ClonalFrame is a tool for the inference of bacterial microevolution. Note: The
  provided help text contains only system error messages regarding a container build
  failure and does not list specific command-line arguments.\n\nTool homepage: https://github.com/xavierdidelot/ClonalFrameML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clonalframe:v1.2-9-deb_cv1
stdout: clonalframe.out
