cwlVersion: v1.2
class: CommandLineTool
baseCommand: reprof
label: reprof
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/ephmo/reprofed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reprof:v1.0.1-6-deb_cv1
stdout: reprof.out
