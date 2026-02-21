cwlVersion: v1.2
class: CommandLineTool
baseCommand: rilseq
label: rilseq
doc: "RIL-seq analysis tool (Note: The provided text is a container build error log
  and does not contain help documentation or argument details).\n\nTool homepage:
  http://github.com/asafpr/RILseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq.out
