cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks_histogram.py
label: data_hacks_histogram.py
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device), and does not contain help text or argument definitions.\n
  \nTool homepage: https://github.com/bitly/data_hacks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks_histogram.py.out
