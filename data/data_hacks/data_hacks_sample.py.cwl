cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks_sample.py
label: data_hacks_sample.py
doc: "A tool from the data_hacks suite (Note: The provided text is a container build
  log and does not contain help information or argument definitions).\n\nTool homepage:
  https://github.com/bitly/data_hacks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks_sample.py.out
