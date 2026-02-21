cwlVersion: v1.2
class: CommandLineTool
baseCommand: DASpatch
label: dascrubber_DASpatch
doc: "A tool from the DASCRUBBER suite. Note: The provided help text contains only
  system error logs regarding a container build failure ('no space left on device')
  and does not list command-line arguments.\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DASpatch.out
