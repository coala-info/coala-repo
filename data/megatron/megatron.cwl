cwlVersion: v1.2
class: CommandLineTool
baseCommand: megatron
label: megatron
doc: "Megatron (Note: The provided text contains error logs and container runtime
  information rather than tool help text, so no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/pinellolab/MEGATRON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megatron:0.1a--py_0
stdout: megatron.out
