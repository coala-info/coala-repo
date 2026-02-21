cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_visualize.py
label: espresso_visualize.py
doc: "The provided text does not contain help information for the tool, but rather
  environment logs and a fatal error regarding disk space during container image conversion.\n
  \nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_visualize.py.out
