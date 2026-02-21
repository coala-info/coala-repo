cwlVersion: v1.2
class: CommandLineTool
baseCommand: openslide
label: openslide
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/OpenSlides/OpenSlides"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openslide:3.4.1--0
stdout: openslide.out
