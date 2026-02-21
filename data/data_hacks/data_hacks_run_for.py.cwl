cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks_run_for.py
label: data_hacks_run_for.py
doc: "A tool from the data_hacks suite (Note: The provided help text contains only
  system logs and error messages regarding a container build failure, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/bitly/data_hacks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks_run_for.py.out
