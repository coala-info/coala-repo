cwlVersion: v1.2
class: CommandLineTool
baseCommand: CCMetagen_merge.py
label: ccmetagen_CCMetagen_merge.py
doc: "Merge CCMetagen results. (Note: The provided help text contains only system
  error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/vrmarcelino/CCMetagen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0
stdout: ccmetagen_CCMetagen_merge.py.out
