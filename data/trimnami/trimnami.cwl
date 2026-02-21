cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimnami
label: trimnami
doc: "Trimnami is a tool for the rapid pre-processing of metagenomic sequencing reads.
  (Note: The provided text is an error log indicating a failed container build due
  to insufficient disk space and does not contain usage information.)\n\nTool homepage:
  https://github.com/beardymcjohnface/Trimnami"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
stdout: trimnami.out
