cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper
label: caper
doc: "Cromwell Assisted Pipeline ExecutoR (Note: The provided text appears to be an
  error log from a container runtime rather than help text; no arguments could be
  extracted from the input.)\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caper:1.1.0--py_0
stdout: caper.out
