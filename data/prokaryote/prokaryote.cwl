cwlVersion: v1.2
class: CommandLineTool
baseCommand: prokaryote
label: prokaryote
doc: "Prokaryotic genome analysis tool (Note: The provided text is a container build
  log and does not contain the tool's help documentation or argument definitions).\n
  \nTool homepage: https://github.com/CellProfiler/prokaryote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prokaryote:2.4.4--pyh5e36f6f_0
stdout: prokaryote.out
