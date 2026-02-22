cwlVersion: v1.2
class: CommandLineTool
baseCommand: anansescanpy
label: anansescanpy
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions.\n\nTool homepage: https://github.com/Arts-of-coding/AnanseScanpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anansescanpy:1.0.0--pyhdfd78af_1
stdout: anansescanpy.out
