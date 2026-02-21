cwlVersion: v1.2
class: CommandLineTool
baseCommand: DASqv
label: dascrubber_DASqv
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error logs regarding a 'no space left on
  device' failure during image extraction.\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DASqv.out
