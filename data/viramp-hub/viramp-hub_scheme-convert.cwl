cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viramp-hub
  - scheme-convert
label: viramp-hub_scheme-convert
doc: "A tool for converting schemes within the viramp-hub suite.\n\nTool homepage:
  https://github.com/wm75/viramp-hub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viramp-hub:0.1.0--pyhdfd78af_0
stdout: viramp-hub_scheme-convert.out
