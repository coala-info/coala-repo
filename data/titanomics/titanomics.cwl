cwlVersion: v1.2
class: CommandLineTool
baseCommand: titanomics
label: titanomics
doc: "Titanomics (Note: The provided text appears to be a container build error log
  rather than help text; no arguments or descriptions could be extracted from the
  input).\n\nTool homepage: https://github.com/raw-lab/titan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/titanomics:0.1--pyh5e36f6f_0
stdout: titanomics.out
