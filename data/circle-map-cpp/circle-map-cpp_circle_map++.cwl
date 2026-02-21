cwlVersion: v1.2
class: CommandLineTool
baseCommand: circle_map++
label: circle-map-cpp_circle_map++
doc: "A tool for circular DNA detection (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
stdout: circle-map-cpp_circle_map++.out
