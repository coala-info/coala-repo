cwlVersion: v1.2
class: CommandLineTool
baseCommand: polars
label: polars
doc: "The provided text does not contain help information for the 'polars' command.
  It appears to be a log of a failed container build/pull process.\n\nTool homepage:
  https://github.com/pola-rs/polars"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polars:0.18.15
stdout: polars.out
