cwlVersion: v1.2
class: CommandLineTool
baseCommand: micall
label: micall-lite_micall
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/PoonLab/MiCall-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micall-lite:0.1rc--py27h14c3975_0
stdout: micall-lite_micall.out
