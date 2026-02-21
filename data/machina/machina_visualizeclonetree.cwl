cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - machina
  - visualizeclonetree
label: machina_visualizeclonetree
doc: "A tool within the MACHINA suite for visualizing clone trees. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_visualizeclonetree.out
