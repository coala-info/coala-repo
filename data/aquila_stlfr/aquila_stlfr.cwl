cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquila_stlfr
label: aquila_stlfr
doc: "Aquila_stLFR is a tool for diploid genome assembly using stLFR (single tube
  Long Fragment Read) data. Note: The provided text appears to be a container runtime
  error log rather than help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/maiziex/Aquila_stLFR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_stlfr.out
