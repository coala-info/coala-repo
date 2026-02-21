cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiline
label: hiline
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime environment.\n\nTool homepage:
  https://github.com/wtsi-hpag/HiLine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
stdout: hiline.out
