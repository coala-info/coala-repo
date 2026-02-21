cwlVersion: v1.2
class: CommandLineTool
baseCommand: hivtrace_hivtrace_viz
label: hivtrace_hivtrace_viz
doc: "HIV-TRACE (TRAnsmission Cluster Engine) visualization tool. (Note: The provided
  input text contains system error messages regarding container execution and does
  not include usage instructions or argument definitions.)\n\nTool homepage: https://github.com/veg/hivtrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hivtrace:1.5.0--py_0
stdout: hivtrace_hivtrace_viz.out
