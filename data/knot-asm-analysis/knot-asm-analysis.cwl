cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot-asm-analysis
label: knot-asm-analysis
doc: "A tool for knot analysis of assembly graphs. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/natir/knot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
stdout: knot-asm-analysis.out
