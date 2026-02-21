cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango_contigtax
label: tango_contigtax
doc: "Taxonomic assignment of contigs (Note: The provided help text contains a fatal
  container execution error and does not list usage or arguments).\n\nTool homepage:
  https://github.com/johnne/tango"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_contigtax.out
