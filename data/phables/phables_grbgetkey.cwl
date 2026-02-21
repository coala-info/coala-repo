cwlVersion: v1.2
class: CommandLineTool
baseCommand: phables_grbgetkey
label: phables_grbgetkey
doc: "The provided text does not contain help information or documentation for the
  tool; it consists of system logs and a fatal error message regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/Vini2/phables"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
stdout: phables_grbgetkey.out
