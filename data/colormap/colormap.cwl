cwlVersion: v1.2
class: CommandLineTool
baseCommand: colormap
label: colormap
doc: "The provided text does not contain help information for the 'colormap' tool;
  it contains system error messages regarding container image retrieval and disk space
  issues.\n\nTool homepage: https://github.com/kbinani/colormap-shaders"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/colormap:v1.0.2-1-deb-py3_cv1
stdout: colormap.out
