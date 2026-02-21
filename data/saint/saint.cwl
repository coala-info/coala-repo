cwlVersion: v1.2
class: CommandLineTool
baseCommand: saint
label: saint
doc: "The provided text does not contain help information or usage instructions for
  the tool 'saint'. It appears to be a log of a failed container build/pull process.\n
  \nTool homepage: https://github.com/tiagorlampert/sAINT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/saint:v2.5.0dfsg-3-deb_cv1
stdout: saint.out
