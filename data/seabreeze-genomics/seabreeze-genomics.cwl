cwlVersion: v1.2
class: CommandLineTool
baseCommand: seabreeze-genomics
label: seabreeze-genomics
doc: "Seabreeze Genomics tool (Note: The provided text appears to be a container build
  error log rather than CLI help text, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/barricklab/seabreeze"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
stdout: seabreeze-genomics.out
