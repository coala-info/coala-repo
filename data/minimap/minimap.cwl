cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap
label: minimap
doc: "A tool for fast mapping of long DNA reads. (Note: The provided text is an error
  message regarding container image acquisition and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/lh3/minimap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minimap:v0.2-4-deb_cv1
stdout: minimap.out
