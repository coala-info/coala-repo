cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genera
  - hmmEra
label: genera_hmmEra
doc: "A tool within the genera package. Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/josuebarrera/GenEra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
stdout: genera_hmmEra.out
