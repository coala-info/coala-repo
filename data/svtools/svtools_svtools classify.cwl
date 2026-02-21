cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - classify
label: svtools_svtools classify
doc: "Classify structural variants (Note: The provided help text contains only container
  runtime error messages and no argument definitions).\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools classify.out
