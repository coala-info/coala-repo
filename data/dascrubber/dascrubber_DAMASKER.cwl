cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAMASKER
label: dascrubber_DAMASKER
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DAMASKER.out
