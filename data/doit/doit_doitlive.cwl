cwlVersion: v1.2
class: CommandLineTool
baseCommand: doit
label: doit_doitlive
doc: "The provided text contains error logs from a container runtime environment rather
  than the tool's help documentation. No functional description or arguments could
  be extracted.\n\nTool homepage: https://github.com/sloria/doitlive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doit:0.29.0--py27_0
stdout: doit_doitlive.out
