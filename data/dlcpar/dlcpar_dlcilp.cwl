cwlVersion: v1.2
class: CommandLineTool
baseCommand: dlcpar_dlcilp
label: dlcpar_dlcilp
doc: "A tool for Duplication-Loss-Coalescence Parsimony (DLCpar). Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/wutron/dlcpar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dlcpar:1.0--py27_0
stdout: dlcpar_dlcilp.out
