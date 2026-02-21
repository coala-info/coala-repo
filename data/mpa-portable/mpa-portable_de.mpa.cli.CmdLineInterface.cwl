cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa-portable
label: mpa-portable_de.mpa.cli.CmdLineInterface
doc: "Metaproteomics Analysis (MPA) portable command-line interface. Note: The provided
  text contains system error logs regarding container execution and does not list
  specific tool arguments.\n\nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-portable:2.0.0--0
stdout: mpa-portable_de.mpa.cli.CmdLineInterface.out
