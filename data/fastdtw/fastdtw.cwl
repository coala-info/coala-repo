cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastdtw
label: fastdtw
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages regarding disk space.\n\nTool
  homepage: https://github.com/slaypni/fastdtw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastdtw:0.2.0--py35_0
stdout: fastdtw.out
