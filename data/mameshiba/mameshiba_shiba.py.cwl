cwlVersion: v1.2
class: CommandLineTool
baseCommand: mameshiba_shiba.py
label: mameshiba_shiba.py
doc: "A tool from the mameshiba package (Note: The provided help text contains only
  system error logs and does not list command-line arguments).\n\nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mameshiba:0.8.1--hdfd78af_0
stdout: mameshiba_shiba.py.out
