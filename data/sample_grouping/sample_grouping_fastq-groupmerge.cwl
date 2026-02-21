cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sample_grouping
  - fastq-groupmerge
label: sample_grouping_fastq-groupmerge
doc: "Merge grouped FASTQ files (Note: The provided help text contains only system
  error logs and does not list specific arguments or options).\n\nTool homepage: https://github.com/SantaMcCloud/Sample_grouping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sample_grouping:1.0.0--pyhdfd78af_0
stdout: sample_grouping_fastq-groupmerge.out
