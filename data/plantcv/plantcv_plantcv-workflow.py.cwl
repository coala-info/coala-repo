cwlVersion: v1.2
class: CommandLineTool
baseCommand: plantcv-workflow.py
label: plantcv_plantcv-workflow.py
doc: "The provided text is an error log indicating a failure to build or run the container
  image due to insufficient disk space ('no space left on device'). It does not contain
  the help text or argument definitions for the tool.\n\nTool homepage: https://plantcv.danforthcenter.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plantcv:3.8.0--py_0
stdout: plantcv_plantcv-workflow.py.out
