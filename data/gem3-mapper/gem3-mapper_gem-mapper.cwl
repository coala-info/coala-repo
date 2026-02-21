cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem-mapper
label: gem3-mapper_gem-mapper
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/smarco/gem3-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper_gem-mapper.out
