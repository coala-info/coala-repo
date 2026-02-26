cwlVersion: v1.2
class: CommandLineTool
baseCommand: circle_map++
label: circle-map-cpp_circle_map++
doc: "the circle_map++ suite, version=0.2.2\n\nTool homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp"
inputs:
  - id: subprogram
    type: string
    doc: 'The subprogram to run. Available commands: Realign, ReadExtractor.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
stdout: circle-map-cpp_circle_map++.out
