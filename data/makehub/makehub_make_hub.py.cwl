cwlVersion: v1.2
class: CommandLineTool
baseCommand: makehub_make_hub.py
label: makehub_make_hub.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding container image building (no space left on device).\n
  \nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
stdout: makehub_make_hub.py.out
