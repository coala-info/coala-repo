cwlVersion: v1.2
class: CommandLineTool
baseCommand: calitas
label: calitas
doc: "The provided text does not contain help information for the tool 'calitas'.
  It contains error logs related to a container build failure ('no space left on device').
  No arguments or descriptions could be extracted from the provided text.\n\nTool
  homepage: https://github.com/editasmedicine/calitas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calitas:1.0--hdfd78af_1
stdout: calitas.out
