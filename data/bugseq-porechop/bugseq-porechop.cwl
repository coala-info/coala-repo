cwlVersion: v1.2
class: CommandLineTool
baseCommand: bugseq-porechop
label: bugseq-porechop
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages regarding a lack of disk space during a
  container execution attempt.\n\nTool homepage: https://gitlab.com/bugseq/porechop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bugseq-porechop:0.3.4pre--py36h2ad2d48_2
stdout: bugseq-porechop.out
