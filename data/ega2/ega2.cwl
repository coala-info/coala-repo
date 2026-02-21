cwlVersion: v1.2
class: CommandLineTool
baseCommand: ega2
label: ega2
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://ega-archive.org/download/downloader-quickguide-v2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega2:2.2.2--0
stdout: ega2.out
