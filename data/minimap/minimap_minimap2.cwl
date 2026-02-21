cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap
label: minimap_minimap2
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/lh3/minimap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minimap:v0.2-4-deb_cv1
stdout: minimap_minimap2.out
