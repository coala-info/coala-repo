cwlVersion: v1.2
class: CommandLineTool
baseCommand: deacon index
label: deacon_index
doc: "Build, inspect, compose and fetch minimizer indexes\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: command
    type: string
    doc: Command to execute (build, union, intersect, diff, dump, info, fetch, 
      help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
stdout: deacon_index.out
