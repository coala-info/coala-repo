cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - gtdbtk
label: metagem_gtdbtk
doc: "The GTDB-Tk module of the MetaGEM pipeline. Note: The provided help text contains
  only system error logs regarding container image extraction and does not list available
  command-line arguments.\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_gtdbtk.out
