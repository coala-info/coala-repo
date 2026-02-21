cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fast5-research
  - extract_read_summary
label: fast5-research_extract_read_summary
doc: "Extract read summary information from fast5 files.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
stdout: fast5-research_extract_read_summary.out
