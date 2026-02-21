cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimns_vgp
label: trimns_vgp
doc: "A tool for trimming Ns from sequences (description not available in provided
  text due to execution error).\n\nTool homepage: https://github.com/VGP/vgp-assembly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimns_vgp:1.0--py_0
stdout: trimns_vgp.out
