cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub_bam_frag_coverage.py
label: wub_bam_frag_coverage.py
doc: "A tool for calculating fragment coverage from BAM files. (Note: The provided
  help text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_frag_coverage.py.out
