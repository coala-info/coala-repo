cwlVersion: v1.2
class: CommandLineTool
baseCommand: circle-map-cpp
label: circle-map-cpp
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
stdout: circle-map-cpp.out
