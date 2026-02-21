cwlVersion: v1.2
class: CommandLineTool
baseCommand: favites_lite
label: favites_lite
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime environment.\n\nTool
  homepage: https://github.com/niemasd/FAVITES-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/favites_lite:1.0.3--hdfd78af_0
stdout: favites_lite.out
