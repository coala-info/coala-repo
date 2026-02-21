cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - goldrush
  - path-polish
label: goldrush_path-polish
doc: "A tool within the GoldRush suite for genome assembly polishing. (Note: The provided
  help text contains only container runtime error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
stdout: goldrush_path-polish.out
