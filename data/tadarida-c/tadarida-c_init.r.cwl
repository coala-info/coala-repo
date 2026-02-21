cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-c_init.r
label: tadarida-c_init.r
doc: "Initialization script for Tadarida-C. Note: The provided help text contains
  only container runtime logs and error messages, and does not list specific command-line
  arguments or usage instructions.\n\nTool homepage: https://github.com/YvesBas/Tadarida-C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-c:1.2--r3.4.1_0
stdout: tadarida-c_init.r.out
