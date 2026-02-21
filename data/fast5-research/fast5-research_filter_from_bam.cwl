cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5-research_filter_from_bam
label: fast5-research_filter_from_bam
doc: "A tool from the fast5-research suite (description unavailable due to execution
  error in provided text).\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
stdout: fast5-research_filter_from_bam.out
