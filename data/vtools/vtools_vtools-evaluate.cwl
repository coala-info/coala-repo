cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vtools
  - evaluate
label: vtools_vtools-evaluate
doc: "Evaluate variant calling results (Note: The provided help text contains only
  container runtime error messages and no argument definitions).\n\nTool homepage:
  https://github.com/LUMC/vtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-evaluate.out
