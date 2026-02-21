cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-c_write_tabase3HF.r
label: tadarida-c_write_tabase3HF.r
doc: "The provided text is a container engine error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/YvesBas/Tadarida-C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-c:1.2--r3.4.1_0
stdout: tadarida-c_write_tabase3HF.r.out
