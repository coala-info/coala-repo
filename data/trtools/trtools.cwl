cwlVersion: v1.2
class: CommandLineTool
baseCommand: trtools
label: trtools
doc: "No description available: The provided text is a container build error log,
  not help text.\n\nTool homepage: http://github.com/gymreklab/TRTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trtools:6.1.0--pyhdfd78af_1
stdout: trtools.out
