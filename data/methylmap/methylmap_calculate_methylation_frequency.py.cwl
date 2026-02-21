cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylmap_calculate_methylation_frequency.py
label: methylmap_calculate_methylation_frequency.py
doc: "Calculate methylation frequency from call files (Note: The provided help text
  contained only system error messages and no argument definitions).\n\nTool homepage:
  https://github.com/EliseCoopman/methylmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylmap:0.5.11--pyhdfd78af_0
stdout: methylmap_calculate_methylation_frequency.py.out
