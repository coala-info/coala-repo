cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - knot-asm-analysis
  - knot
label: knot-asm-analysis_knot
doc: "Knot-asm-analysis tool (Note: The provided help text contains system error messages
  regarding container execution and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/natir/knot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
stdout: knot-asm-analysis_knot.out
