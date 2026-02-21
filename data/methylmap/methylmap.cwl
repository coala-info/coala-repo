cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylmap
label: methylmap
doc: "A tool for DNA methylation mapping and visualization. (Note: The provided text
  is a container runtime error log and does not contain command-line usage or argument
  information.)\n\nTool homepage: https://github.com/EliseCoopman/methylmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylmap:0.5.11--pyhdfd78af_0
stdout: methylmap.out
