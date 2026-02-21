cwlVersion: v1.2
class: CommandLineTool
baseCommand: staphb-tk
label: staphb_toolkit_staphb-tk
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error message regarding a container build failure.\n
  \nTool homepage: https://staphb.org/staphb_toolkit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/staphb_toolkit:2.0.1--pyhdfd78af_0
stdout: staphb_toolkit_staphb-tk.out
