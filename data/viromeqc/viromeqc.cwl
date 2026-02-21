cwlVersion: v1.2
class: CommandLineTool
baseCommand: viromeqc
label: viromeqc
doc: "ViromeQC is a tool for the quality control of virome metagenomes. (Note: The
  provided text contains only container execution logs and no help information; arguments
  could not be extracted from the input.)\n\nTool homepage: https://github.com/SegataLab/viromeqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viromeqc:1.0.2--py310h7cba7a3_0
stdout: viromeqc.out
