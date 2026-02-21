cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgt
label: bgt
doc: "Binary Genotype Tool (Note: The provided text is a container build error log
  and does not contain help documentation or argument definitions for the tool.)\n
  \nTool homepage: https://github.com/Dysman/bgTools-playerPrefsEditor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h7132678_4
stdout: bgt.out
