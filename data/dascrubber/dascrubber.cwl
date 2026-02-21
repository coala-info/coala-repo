cwlVersion: v1.2
class: CommandLineTool
baseCommand: dascrubber
label: dascrubber
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber.out
