cwlVersion: v1.2
class: CommandLineTool
baseCommand: paired_end_read_merger
label: smallgenomeutilities_paired_end_read_merger
doc: "A tool for merging paired-end reads. Note: The provided help text contains only
  container execution logs and error messages, so no specific arguments could be extracted.\n
  \nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_paired_end_read_merger.out
