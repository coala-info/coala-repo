cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fast5_index
label: fast5-research_fast5_index
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
stdout: fast5-research_fast5_index.out
