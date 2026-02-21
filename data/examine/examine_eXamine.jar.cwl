cwlVersion: v1.2
class: CommandLineTool
baseCommand: examine
label: examine_eXamine.jar
doc: "The provided text does not contain help information as it is a system error
  log indicating a failure to build the container image due to insufficient disk space.
  No arguments or descriptions could be extracted from the input.\n\nTool homepage:
  https://github.com/AlBi-HHU/eXamine-stand-alone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/examine:1.0.1--hdfd78af_0
stdout: examine_eXamine.jar.out
