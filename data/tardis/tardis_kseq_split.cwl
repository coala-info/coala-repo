cwlVersion: v1.2
class: CommandLineTool
baseCommand: tardis_kseq_split
label: tardis_kseq_split
doc: "A tool for splitting sequence files. (Note: The provided help text contains
  container runtime error messages and does not include specific usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/AgResearch/tardis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tardis:1.0.19--py27ha92aebf_0
stdout: tardis_kseq_split.out
