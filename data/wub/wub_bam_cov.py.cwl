cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub_bam_cov.py
label: wub_bam_cov.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_cov.py.out
