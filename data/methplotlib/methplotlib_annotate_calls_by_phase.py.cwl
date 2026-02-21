cwlVersion: v1.2
class: CommandLineTool
baseCommand: methplotlib_annotate_calls_by_phase.py
label: methplotlib_annotate_calls_by_phase.py
doc: "Annotate methylation calls by phase (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/wdecoster/methplotlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methplotlib:0.21.2--pyhdfd78af_0
stdout: methplotlib_annotate_calls_by_phase.py.out
