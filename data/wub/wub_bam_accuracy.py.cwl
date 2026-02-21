cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub_bam_accuracy.py
label: wub_bam_accuracy.py
doc: "BAM accuracy analysis tool (Note: The provided text appears to be a container
  build error log rather than help text, so no arguments could be extracted).\n\n
  Tool homepage: https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_accuracy.py.out
