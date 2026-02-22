cwlVersion: v1.2
class: CommandLineTool
baseCommand: pango_aliasor
label: pango_aliasor
doc: "A tool for handling Pango lineage aliases. Note: The provided help text indicates
  a fatal error during execution/container retrieval rather than displaying standard
  help documentation.\n\nTool homepage: https://github.com/corneliusroemer/pango_aliasor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pango-designation:1.37--pyh2628382_0
stdout: pango_aliasor.out
