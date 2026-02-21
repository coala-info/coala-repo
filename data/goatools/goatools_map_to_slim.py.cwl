cwlVersion: v1.2
class: CommandLineTool
baseCommand: goatools_map_to_slim.py
label: goatools_map_to_slim.py
doc: "Map GO terms to a GO slim (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/tanghaibao/goatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2
stdout: goatools_map_to_slim.py.out
