cwlVersion: v1.2
class: CommandLineTool
baseCommand: micall-lite
label: micall-lite
doc: "The provided text is an error log from a container runtime and does not contain
  help information or a description of the tool's functionality.\n\nTool homepage:
  https://github.com/PoonLab/MiCall-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micall-lite:0.1rc--py27h14c3975_0
stdout: micall-lite.out
