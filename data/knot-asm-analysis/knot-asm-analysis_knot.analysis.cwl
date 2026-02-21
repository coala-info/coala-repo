cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.analysis
label: knot-asm-analysis_knot.analysis
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a failure to build a SIF image due to
  insufficient disk space.\n\nTool homepage: https://github.com/natir/knot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
stdout: knot-asm-analysis_knot.analysis.out
