cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAStrim
label: dascrubber_DAStrim
doc: "The provided input text does not contain help information for the tool, but
  rather a system error log indicating a failure to build or extract a container image
  due to lack of disk space. No arguments or usage instructions could be extracted.\n
  \nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DAStrim.out
