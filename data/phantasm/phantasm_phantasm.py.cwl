cwlVersion: v1.2
class: CommandLineTool
baseCommand: phantasm.py
label: phantasm_phantasm.py
doc: "PHylogenomic ANalyses for Taxonomic AssignMent (Note: The provided text is a
  container execution log indicating a 'no space left on device' error and does not
  contain the standard help/usage information for the tool.)\n\nTool homepage: https://github.com/dr-joe-wirth/phantasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phantasm:1.1.3--pyhdfd78af_0
stdout: phantasm_phantasm.py.out
