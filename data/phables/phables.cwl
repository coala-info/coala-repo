cwlVersion: v1.2
class: CommandLineTool
baseCommand: phables
label: phables
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system log showing a fatal error during a container build process
  (no space left on device).\n\nTool homepage: https://github.com/Vini2/phables"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
stdout: phables.out
